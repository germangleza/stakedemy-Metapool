use crate::*;

#[near_bindgen]
impl Contract {

    // Public - get donation by account ID
  pub fn get_amount_for_account(&self, account_id: AccountId) -> Membership {
    Membership {
      account_id: account_id.clone(),
      total_amount: U128(self.total_deposit.get(&account_id).unwrap_or(0))
    }
  }

  pub fn get_amount_to_unstake(&self, account_id: AccountId) -> Membership {
    Membership {
      account_id: account_id.clone(),
      total_amount: U128(self.deposit_to_withdraw.get(&account_id).unwrap_or(0))
    }
  }

  // Public - get total number of donors
  pub fn number_of_members(&self) -> u64 {
    self.total_deposit.len()
  }

  // Public - paginate through all donations on the contract
  pub fn get_memberships(&self, from_index: Option<U128>, limit: Option<u64>) -> Vec<Membership> {
    //where to start pagination - if we have a from_index, we'll use that - otherwise start from 0 index
    let start = u128::from(from_index.unwrap_or(U128(0)));

    //iterate through donation
    self.total_deposit.keys()
      //skip to the index we specified in the start variable
      .skip(start as usize) 
      //take the first "limit" elements in the vector. If we didn't specify a limit, use 50
      .take(limit.unwrap_or(50) as usize) 
      .map(|account| self.get_amount_for_account(account))
      //since we turned map into an iterator, we need to turn it back into a vector to return
      .collect()
  }

    //get the total supply of NFTs for a given owner
    pub fn deposit_supply_for_owner(
        &self,
        account_id: AccountId,
    ) -> U128 {
        //get the set of tokens for the passed in owner
        let deposit_for_owner_set = self.deposits_per_owner.get(&account_id);

        //if there is some set of tokens, we'll return the length as a U128
        if let Some(deposit_for_owner_set) = deposit_for_owner_set {
            U128(deposit_for_owner_set.len() as u128)
        } else {
            //if there isn't a set of tokens for the passed in account ID, we'll return 0
            U128(0)
        }
    }
}