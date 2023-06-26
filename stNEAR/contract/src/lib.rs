use near_sdk::borsh::{self, BorshDeserialize, BorshSerialize};
use std::collections::HashMap;
use near_sdk::{env, near_bindgen, AccountId};
use near_sdk::collections::{LookupMap, UnorderedMap, UnorderedSet};
use near_sdk::serde::{Deserialize, Serialize};
use near_sdk::json_types::U128;
/// Raw type for timestamp in nanoseconds
pub type Timestamp = u64;
/// Raw type for 32 bytes of the hash.
pub type CryptoHash = [u8; 32];

use crate::internal::*;
pub use crate::xcc::*;
pub use crate::subscribe::*;
pub use crate::enumeration::*;

mod internal;
mod subscribe;
mod xcc;
mod enumeration;

#[near_bindgen]
#[derive(BorshDeserialize, BorshSerialize)]
pub struct Contract {
  pub vault: AccountId,
  pub total_deposit: UnorderedMap<AccountId, u128>,
  pub timelocked: UnorderedMap<AccountId, Timestamp>,
  pub deposit_to_withdraw: UnorderedMap<AccountId, u128>,
  pub deposits_per_owner: LookupMap<AccountId, UnorderedSet<Timestamp>>,
  pub metapoolcontract: String
}

/// Helper structure for keys of the persistent collections.
#[derive(BorshSerialize)]
pub enum StorageKey {
    DepositsPerOwner,
    DepositsPerOwnerInner { account_id_hash: CryptoHash },
}

impl Default for Contract {
  fn default() -> Self {
    Self{
      vault: "stakedemy.testnet".parse().unwrap(),
      metapoolcontract: "meta-v2.pool.testnet".parse().unwrap(),
      total_deposit: UnorderedMap::new(b"a"),
      timelocked: UnorderedMap::new(b"d"),
      deposit_to_withdraw: UnorderedMap::new(b"c"),
      deposits_per_owner: LookupMap::new(StorageKey::DepositsPerOwner.try_to_vec().unwrap()),
    }
  }
}

#[near_bindgen]
impl Contract {
  #[init]
  #[private] // Public - but only callable by env::current_account_id()
  pub fn init(vault: AccountId) -> Self {
    Self {
      vault,
      metapoolcontract: "meta-v2.pool.testnet".parse().unwrap(),
      deposit_to_withdraw: UnorderedMap::new(b"c"),
      timelocked: UnorderedMap::new(b"d"),
      total_deposit: UnorderedMap::new(b"a"),
      deposits_per_owner: LookupMap::new(StorageKey::DepositsPerOwner.try_to_vec().unwrap()),
    }
  }

  // Public - vault getter
  pub fn get_vault(&self) -> AccountId {
    self.vault.clone()
  }

  // Public - but only callable by env::current_account_id(). Sets the vault
  #[private]
  pub fn change_vault(&mut self, vault: AccountId) {
    self.vault = vault;
  }
}