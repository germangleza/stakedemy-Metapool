
// File contracts/ITreasury.sol

pragma solidity 0.8.10;

interface ITreasury {
    function payRewards(
        address _user,
        address _token,
        uint256 _deposit
    ) external;

    function isSupportedToken(address token) external view returns (bool);
}


// File @openzeppelin/contracts-upgradeable/proxy/beacon/IBeaconUpgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (proxy/beacon/IBeacon.sol)

pragma solidity ^0.8.0;

/**
 * @dev This is the interface that {BeaconProxy} expects of its beacon.
 */
interface IBeaconUpgradeable {
    /**
     * @dev Must return an address that can be used as a delegate call target.
     *
     * {BeaconProxy} will check that this address is a contract.
     */
    function implementation() external view returns (address);
}


// File @openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (utils/Address.sol)

pragma solidity ^0.8.0;

/**
 * @dev Collection of functions related to the address type
 */
library AddressUpgradeable {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


// File @openzeppelin/contracts-upgradeable/utils/StorageSlotUpgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (utils/StorageSlot.sol)

pragma solidity ^0.8.0;

/**
 * @dev Library for reading and writing primitive types to specific storage slots.
 *
 * Storage slots are often used to avoid storage conflict when dealing with upgradeable contracts.
 * This library helps with reading and writing to such slots without the need for inline assembly.
 *
 * The functions in this library return Slot structs that contain a `value` member that can be used to read or write.
 *
 * Example usage to set ERC1967 implementation slot:
 * ```
 * contract ERC1967 {
 *     bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
 *
 *     function _getImplementation() internal view returns (address) {
 *         return StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value;
 *     }
 *
 *     function _setImplementation(address newImplementation) internal {
 *         require(Address.isContract(newImplementation), "ERC1967: new implementation is not a contract");
 *         StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value = newImplementation;
 *     }
 * }
 * ```
 *
 * _Available since v4.1 for `address`, `bool`, `bytes32`, and `uint256`._
 */
library StorageSlotUpgradeable {
    struct AddressSlot {
        address value;
    }

    struct BooleanSlot {
        bool value;
    }

    struct Bytes32Slot {
        bytes32 value;
    }

    struct Uint256Slot {
        uint256 value;
    }

    /**
     * @dev Returns an `AddressSlot` with member `value` located at `slot`.
     */
    function getAddressSlot(bytes32 slot) internal pure returns (AddressSlot storage r) {
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `BooleanSlot` with member `value` located at `slot`.
     */
    function getBooleanSlot(bytes32 slot) internal pure returns (BooleanSlot storage r) {
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `Bytes32Slot` with member `value` located at `slot`.
     */
    function getBytes32Slot(bytes32 slot) internal pure returns (Bytes32Slot storage r) {
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `Uint256Slot` with member `value` located at `slot`.
     */
    function getUint256Slot(bytes32 slot) internal pure returns (Uint256Slot storage r) {
        assembly {
            r.slot := slot
        }
    }
}


// File @openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (proxy/utils/Initializable.sol)

pragma solidity ^0.8.0;

/**
 * @dev This is a base contract to aid in writing upgradeable contracts, or any kind of contract that will be deployed
 * behind a proxy. Since a proxied contract can't have a constructor, it's common to move constructor logic to an
 * external initializer function, usually called `initialize`. It then becomes necessary to protect this initializer
 * function so it can only be called once. The {initializer} modifier provided by this contract will have this effect.
 *
 * TIP: To avoid leaving the proxy in an uninitialized state, the initializer function should be called as early as
 * possible by providing the encoded function call as the `_data` argument to {ERC1967Proxy-constructor}.
 *
 * CAUTION: When used with inheritance, manual care must be taken to not invoke a parent initializer twice, or to ensure
 * that all initializers are idempotent. This is not verified automatically as constructors are by Solidity.
 *
 * [CAUTION]
 * ====
 * Avoid leaving a contract uninitialized.
 *
 * An uninitialized contract can be taken over by an attacker. This applies to both a proxy and its implementation
 * contract, which may impact the proxy. To initialize the implementation contract, you can either invoke the
 * initializer manually, or you can include a constructor to automatically mark it as initialized when it is deployed:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * /// @custom:oz-upgrades-unsafe-allow constructor
 * constructor() initializer {}
 * ```
 * ====
 */
abstract contract Initializable {
    /**
     * @dev Indicates that the contract has been initialized.
     */
    bool private _initialized;

    /**
     * @dev Indicates that the contract is in the process of being initialized.
     */
    bool private _initializing;

    /**
     * @dev Modifier to protect an initializer function from being invoked twice.
     */
    modifier initializer() {
        // If the contract is initializing we ignore whether _initialized is set in order to support multiple
        // inheritance patterns, but we only do this in the context of a constructor, because in other contexts the
        // contract may have been reentered.
        require(_initializing ? _isConstructor() : !_initialized, "Initializable: contract is already initialized");

        bool isTopLevelCall = !_initializing;
        if (isTopLevelCall) {
            _initializing = true;
            _initialized = true;
        }

        _;

        if (isTopLevelCall) {
            _initializing = false;
        }
    }

    /**
     * @dev Modifier to protect an initialization function so that it can only be invoked by functions with the
     * {initializer} modifier, directly or indirectly.
     */
    modifier onlyInitializing() {
        require(_initializing, "Initializable: contract is not initializing");
        _;
    }

    function _isConstructor() private view returns (bool) {
        return !AddressUpgradeable.isContract(address(this));
    }
}


// File @openzeppelin/contracts-upgradeable/proxy/ERC1967/ERC1967UpgradeUpgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (proxy/ERC1967/ERC1967Upgrade.sol)

pragma solidity ^0.8.2;




/**
 * @dev This abstract contract provides getters and event emitting update functions for
 * https://eips.ethereum.org/EIPS/eip-1967[EIP1967] slots.
 *
 * _Available since v4.1._
 *
 * @custom:oz-upgrades-unsafe-allow delegatecall
 */
abstract contract ERC1967UpgradeUpgradeable is Initializable {
    function __ERC1967Upgrade_init() internal onlyInitializing {
        __ERC1967Upgrade_init_unchained();
    }

    function __ERC1967Upgrade_init_unchained() internal onlyInitializing {
    }
    // This is the keccak-256 hash of "eip1967.proxy.rollback" subtracted by 1
    bytes32 private constant _ROLLBACK_SLOT = 0x4910fdfa16fed3260ed0e7147f7cc6da11a60208b5b9406d12a635614ffd9143;

    /**
     * @dev Storage slot with the address of the current implementation.
     * This is the keccak-256 hash of "eip1967.proxy.implementation" subtracted by 1, and is
     * validated in the constructor.
     */
    bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    /**
     * @dev Emitted when the implementation is upgraded.
     */
    event Upgraded(address indexed implementation);

    /**
     * @dev Returns the current implementation address.
     */
    function _getImplementation() internal view returns (address) {
        return StorageSlotUpgradeable.getAddressSlot(_IMPLEMENTATION_SLOT).value;
    }

    /**
     * @dev Stores a new address in the EIP1967 implementation slot.
     */
    function _setImplementation(address newImplementation) private {
        require(AddressUpgradeable.isContract(newImplementation), "ERC1967: new implementation is not a contract");
        StorageSlotUpgradeable.getAddressSlot(_IMPLEMENTATION_SLOT).value = newImplementation;
    }

    /**
     * @dev Perform implementation upgrade
     *
     * Emits an {Upgraded} event.
     */
    function _upgradeTo(address newImplementation) internal {
        _setImplementation(newImplementation);
        emit Upgraded(newImplementation);
    }

    /**
     * @dev Perform implementation upgrade with additional setup call.
     *
     * Emits an {Upgraded} event.
     */
    function _upgradeToAndCall(
        address newImplementation,
        bytes memory data,
        bool forceCall
    ) internal {
        _upgradeTo(newImplementation);
        if (data.length > 0 || forceCall) {
            _functionDelegateCall(newImplementation, data);
        }
    }

    /**
     * @dev Perform implementation upgrade with security checks for UUPS proxies, and additional setup call.
     *
     * Emits an {Upgraded} event.
     */
    function _upgradeToAndCallSecure(
        address newImplementation,
        bytes memory data,
        bool forceCall
    ) internal {
        address oldImplementation = _getImplementation();

        // Initial upgrade and setup call
        _setImplementation(newImplementation);
        if (data.length > 0 || forceCall) {
            _functionDelegateCall(newImplementation, data);
        }

        // Perform rollback test if not already in progress
        StorageSlotUpgradeable.BooleanSlot storage rollbackTesting = StorageSlotUpgradeable.getBooleanSlot(_ROLLBACK_SLOT);
        if (!rollbackTesting.value) {
            // Trigger rollback using upgradeTo from the new implementation
            rollbackTesting.value = true;
            _functionDelegateCall(
                newImplementation,
                abi.encodeWithSignature("upgradeTo(address)", oldImplementation)
            );
            rollbackTesting.value = false;
            // Check rollback was effective
            require(oldImplementation == _getImplementation(), "ERC1967Upgrade: upgrade breaks further upgrades");
            // Finally reset to the new implementation and log the upgrade
            _upgradeTo(newImplementation);
        }
    }

    /**
     * @dev Storage slot with the admin of the contract.
     * This is the keccak-256 hash of "eip1967.proxy.admin" subtracted by 1, and is
     * validated in the constructor.
     */
    bytes32 internal constant _ADMIN_SLOT = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;

    /**
     * @dev Emitted when the admin account has changed.
     */
    event AdminChanged(address previousAdmin, address newAdmin);

    /**
     * @dev Returns the current admin.
     */
    function _getAdmin() internal view returns (address) {
        return StorageSlotUpgradeable.getAddressSlot(_ADMIN_SLOT).value;
    }

    /**
     * @dev Stores a new address in the EIP1967 admin slot.
     */
    function _setAdmin(address newAdmin) private {
        require(newAdmin != address(0), "ERC1967: new admin is the zero address");
        StorageSlotUpgradeable.getAddressSlot(_ADMIN_SLOT).value = newAdmin;
    }

    /**
     * @dev Changes the admin of the proxy.
     *
     * Emits an {AdminChanged} event.
     */
    function _changeAdmin(address newAdmin) internal {
        emit AdminChanged(_getAdmin(), newAdmin);
        _setAdmin(newAdmin);
    }

    /**
     * @dev The storage slot of the UpgradeableBeacon contract which defines the implementation for this proxy.
     * This is bytes32(uint256(keccak256('eip1967.proxy.beacon')) - 1)) and is validated in the constructor.
     */
    bytes32 internal constant _BEACON_SLOT = 0xa3f0ad74e5423aebfd80d3ef4346578335a9a72aeaee59ff6cb3582b35133d50;

    /**
     * @dev Emitted when the beacon is upgraded.
     */
    event BeaconUpgraded(address indexed beacon);

    /**
     * @dev Returns the current beacon.
     */
    function _getBeacon() internal view returns (address) {
        return StorageSlotUpgradeable.getAddressSlot(_BEACON_SLOT).value;
    }

    /**
     * @dev Stores a new beacon in the EIP1967 beacon slot.
     */
    function _setBeacon(address newBeacon) private {
        require(AddressUpgradeable.isContract(newBeacon), "ERC1967: new beacon is not a contract");
        require(
            AddressUpgradeable.isContract(IBeaconUpgradeable(newBeacon).implementation()),
            "ERC1967: beacon implementation is not a contract"
        );
        StorageSlotUpgradeable.getAddressSlot(_BEACON_SLOT).value = newBeacon;
    }

    /**
     * @dev Perform beacon upgrade with additional setup call. Note: This upgrades the address of the beacon, it does
     * not upgrade the implementation contained in the beacon (see {UpgradeableBeacon-_setImplementation} for that).
     *
     * Emits a {BeaconUpgraded} event.
     */
    function _upgradeBeaconToAndCall(
        address newBeacon,
        bytes memory data,
        bool forceCall
    ) internal {
        _setBeacon(newBeacon);
        emit BeaconUpgraded(newBeacon);
        if (data.length > 0 || forceCall) {
            _functionDelegateCall(IBeaconUpgradeable(newBeacon).implementation(), data);
        }
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function _functionDelegateCall(address target, bytes memory data) private returns (bytes memory) {
        require(AddressUpgradeable.isContract(target), "Address: delegate call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return AddressUpgradeable.verifyCallResult(success, returndata, "Address: low-level delegate call failed");
    }
    uint256[50] private __gap;
}


// File @openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (proxy/utils/UUPSUpgradeable.sol)

pragma solidity ^0.8.0;


/**
 * @dev An upgradeability mechanism designed for UUPS proxies. The functions included here can perform an upgrade of an
 * {ERC1967Proxy}, when this contract is set as the implementation behind such a proxy.
 *
 * A security mechanism ensures that an upgrade does not turn off upgradeability accidentally, although this risk is
 * reinstated if the upgrade retains upgradeability but removes the security mechanism, e.g. by replacing
 * `UUPSUpgradeable` with a custom implementation of upgrades.
 *
 * The {_authorizeUpgrade} function must be overridden to include access restriction to the upgrade mechanism.
 *
 * _Available since v4.1._
 */
abstract contract UUPSUpgradeable is Initializable, ERC1967UpgradeUpgradeable {
    function __UUPSUpgradeable_init() internal onlyInitializing {
        __ERC1967Upgrade_init_unchained();
        __UUPSUpgradeable_init_unchained();
    }

    function __UUPSUpgradeable_init_unchained() internal onlyInitializing {
    }
    /// @custom:oz-upgrades-unsafe-allow state-variable-immutable state-variable-assignment
    address private immutable __self = address(this);

    /**
     * @dev Check that the execution is being performed through a delegatecall call and that the execution context is
     * a proxy contract with an implementation (as defined in ERC1967) pointing to self. This should only be the case
     * for UUPS and transparent proxies that are using the current contract as their implementation. Execution of a
     * function through ERC1167 minimal proxies (clones) would not normally pass this test, but is not guaranteed to
     * fail.
     */
    modifier onlyProxy() {
        require(address(this) != __self, "Function must be called through delegatecall");
        require(_getImplementation() == __self, "Function must be called through active proxy");
        _;
    }

    /**
     * @dev Upgrade the implementation of the proxy to `newImplementation`.
     *
     * Calls {_authorizeUpgrade}.
     *
     * Emits an {Upgraded} event.
     */
    function upgradeTo(address newImplementation) external virtual onlyProxy {
        _authorizeUpgrade(newImplementation);
        _upgradeToAndCallSecure(newImplementation, new bytes(0), false);
    }

    /**
     * @dev Upgrade the implementation of the proxy to `newImplementation`, and subsequently execute the function call
     * encoded in `data`.
     *
     * Calls {_authorizeUpgrade}.
     *
     * Emits an {Upgraded} event.
     */
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable virtual onlyProxy {
        _authorizeUpgrade(newImplementation);
        _upgradeToAndCallSecure(newImplementation, data, true);
    }

    /**
     * @dev Function that should revert when `msg.sender` is not authorized to upgrade the contract. Called by
     * {upgradeTo} and {upgradeToAndCall}.
     *
     * Normally, this function will use an xref:access.adoc[access control] modifier such as {Ownable-onlyOwner}.
     *
     * ```solidity
     * function _authorizeUpgrade(address) internal override onlyOwner {}
     * ```
     */
    function _authorizeUpgrade(address newImplementation) internal virtual;
    uint256[50] private __gap;
}


// File @openzeppelin/contracts-upgradeable/access/IAccessControlUpgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (access/IAccessControl.sol)

pragma solidity ^0.8.0;

/**
 * @dev External interface of AccessControl declared to support ERC165 detection.
 */
interface IAccessControlUpgradeable {
    /**
     * @dev Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`
     *
     * `DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
     * {RoleAdminChanged} not being emitted signaling this.
     *
     * _Available since v3.1._
     */
    event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);

    /**
     * @dev Emitted when `account` is granted `role`.
     *
     * `sender` is the account that originated the contract call, an admin role
     * bearer except when using {AccessControl-_setupRole}.
     */
    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Emitted when `account` is revoked `role`.
     *
     * `sender` is the account that originated the contract call:
     *   - if using `revokeRole`, it is the admin role bearer
     *   - if using `renounceRole`, it is the role bearer (i.e. `account`)
     */
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account) external view returns (bool);

    /**
     * @dev Returns the admin role that controls `role`. See {grantRole} and
     * {revokeRole}.
     *
     * To change a role's admin, use {AccessControl-_setRoleAdmin}.
     */
    function getRoleAdmin(bytes32 role) external view returns (bytes32);

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function grantRole(bytes32 role, address account) external;

    /**
     * @dev Revokes `role` from `account`.
     *
     * If `account` had been granted `role`, emits a {RoleRevoked} event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function revokeRole(bytes32 role, address account) external;

    /**
     * @dev Revokes `role` from the calling account.
     *
     * Roles are often managed via {grantRole} and {revokeRole}: this function's
     * purpose is to provide a mechanism for accounts to lose their privileges
     * if they are compromised (such as when a trusted device is misplaced).
     *
     * If the calling account had been granted `role`, emits a {RoleRevoked}
     * event.
     *
     * Requirements:
     *
     * - the caller must be `account`.
     */
    function renounceRole(bytes32 role, address account) external;
}


// File @openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract ContextUpgradeable is Initializable {
    function __Context_init() internal onlyInitializing {
        __Context_init_unchained();
    }

    function __Context_init_unchained() internal onlyInitializing {
    }
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
    uint256[50] private __gap;
}


// File @openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (utils/Strings.sol)

pragma solidity ^0.8.0;

/**
 * @dev String operations.
 */
library StringsUpgradeable {
    bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return toHexString(value, length);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _HEX_SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
}


// File @openzeppelin/contracts-upgradeable/utils/introspection/IERC165Upgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC165.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165Upgradeable {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}


// File @openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (utils/introspection/ERC165.sol)

pragma solidity ^0.8.0;


/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts that want to implement ERC165 should inherit from this contract and override {supportsInterface} to check
 * for the additional interface id that will be supported. For example:
 *
 * ```solidity
 * function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
 *     return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
 * }
 * ```
 *
 * Alternatively, {ERC165Storage} provides an easier to use but more expensive implementation.
 */
abstract contract ERC165Upgradeable is Initializable, IERC165Upgradeable {
    function __ERC165_init() internal onlyInitializing {
        __ERC165_init_unchained();
    }

    function __ERC165_init_unchained() internal onlyInitializing {
    }
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IERC165Upgradeable).interfaceId;
    }
    uint256[50] private __gap;
}


// File @openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (access/AccessControl.sol)

pragma solidity ^0.8.0;





/**
 * @dev Contract module that allows children to implement role-based access
 * control mechanisms. This is a lightweight version that doesn't allow enumerating role
 * members except through off-chain means by accessing the contract event logs. Some
 * applications may benefit from on-chain enumerability, for those cases see
 * {AccessControlEnumerable}.
 *
 * Roles are referred to by their `bytes32` identifier. These should be exposed
 * in the external API and be unique. The best way to achieve this is by
 * using `public constant` hash digests:
 *
 * ```
 * bytes32 public constant MY_ROLE = keccak256("MY_ROLE");
 * ```
 *
 * Roles can be used to represent a set of permissions. To restrict access to a
 * function call, use {hasRole}:
 *
 * ```
 * function foo() public {
 *     require(hasRole(MY_ROLE, msg.sender));
 *     ...
 * }
 * ```
 *
 * Roles can be granted and revoked dynamically via the {grantRole} and
 * {revokeRole} functions. Each role has an associated admin role, and only
 * accounts that have a role's admin role can call {grantRole} and {revokeRole}.
 *
 * By default, the admin role for all roles is `DEFAULT_ADMIN_ROLE`, which means
 * that only accounts with this role will be able to grant or revoke other
 * roles. More complex role relationships can be created by using
 * {_setRoleAdmin}.
 *
 * WARNING: The `DEFAULT_ADMIN_ROLE` is also its own admin: it has permission to
 * grant and revoke this role. Extra precautions should be taken to secure
 * accounts that have been granted it.
 */
abstract contract AccessControlUpgradeable is Initializable, ContextUpgradeable, IAccessControlUpgradeable, ERC165Upgradeable {
    function __AccessControl_init() internal onlyInitializing {
        __Context_init_unchained();
        __ERC165_init_unchained();
        __AccessControl_init_unchained();
    }

    function __AccessControl_init_unchained() internal onlyInitializing {
    }
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }

    mapping(bytes32 => RoleData) private _roles;

    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

    /**
     * @dev Modifier that checks that an account has a specific role. Reverts
     * with a standardized message including the required role.
     *
     * The format of the revert reason is given by the following regular expression:
     *
     *  /^AccessControl: account (0x[0-9a-f]{40}) is missing role (0x[0-9a-f]{64})$/
     *
     * _Available since v4.1._
     */
    modifier onlyRole(bytes32 role) {
        _checkRole(role, _msgSender());
        _;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IAccessControlUpgradeable).interfaceId || super.supportsInterface(interfaceId);
    }

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account) public view override returns (bool) {
        return _roles[role].members[account];
    }

    /**
     * @dev Revert with a standard message if `account` is missing `role`.
     *
     * The format of the revert reason is given by the following regular expression:
     *
     *  /^AccessControl: account (0x[0-9a-f]{40}) is missing role (0x[0-9a-f]{64})$/
     */
    function _checkRole(bytes32 role, address account) internal view {
        if (!hasRole(role, account)) {
            revert(
                string(
                    abi.encodePacked(
                        "AccessControl: account ",
                        StringsUpgradeable.toHexString(uint160(account), 20),
                        " is missing role ",
                        StringsUpgradeable.toHexString(uint256(role), 32)
                    )
                )
            );
        }
    }

    /**
     * @dev Returns the admin role that controls `role`. See {grantRole} and
     * {revokeRole}.
     *
     * To change a role's admin, use {_setRoleAdmin}.
     */
    function getRoleAdmin(bytes32 role) public view override returns (bytes32) {
        return _roles[role].adminRole;
    }

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function grantRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _grantRole(role, account);
    }

    /**
     * @dev Revokes `role` from `account`.
     *
     * If `account` had been granted `role`, emits a {RoleRevoked} event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function revokeRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _revokeRole(role, account);
    }

    /**
     * @dev Revokes `role` from the calling account.
     *
     * Roles are often managed via {grantRole} and {revokeRole}: this function's
     * purpose is to provide a mechanism for accounts to lose their privileges
     * if they are compromised (such as when a trusted device is misplaced).
     *
     * If the calling account had been revoked `role`, emits a {RoleRevoked}
     * event.
     *
     * Requirements:
     *
     * - the caller must be `account`.
     */
    function renounceRole(bytes32 role, address account) public virtual override {
        require(account == _msgSender(), "AccessControl: can only renounce roles for self");

        _revokeRole(role, account);
    }

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event. Note that unlike {grantRole}, this function doesn't perform any
     * checks on the calling account.
     *
     * [WARNING]
     * ====
     * This function should only be called from the constructor when setting
     * up the initial roles for the system.
     *
     * Using this function in any other way is effectively circumventing the admin
     * system imposed by {AccessControl}.
     * ====
     *
     * NOTE: This function is deprecated in favor of {_grantRole}.
     */
    function _setupRole(bytes32 role, address account) internal virtual {
        _grantRole(role, account);
    }

    /**
     * @dev Sets `adminRole` as ``role``'s admin role.
     *
     * Emits a {RoleAdminChanged} event.
     */
    function _setRoleAdmin(bytes32 role, bytes32 adminRole) internal virtual {
        bytes32 previousAdminRole = getRoleAdmin(role);
        _roles[role].adminRole = adminRole;
        emit RoleAdminChanged(role, previousAdminRole, adminRole);
    }

    /**
     * @dev Grants `role` to `account`.
     *
     * Internal function without access restriction.
     */
    function _grantRole(bytes32 role, address account) internal virtual {
        if (!hasRole(role, account)) {
            _roles[role].members[account] = true;
            emit RoleGranted(role, account, _msgSender());
        }
    }

    /**
     * @dev Revokes `role` from `account`.
     *
     * Internal function without access restriction.
     */
    function _revokeRole(bytes32 role, address account) internal virtual {
        if (hasRole(role, account)) {
            _roles[role].members[account] = false;
            emit RoleRevoked(role, account, _msgSender());
        }
    }
    uint256[49] private __gap;
}


// File contracts/AdminControlled.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.10;


/**
 * @title AdminControlled
 * @author Aurora Team
 *
 * @dev Implementation of Admin controlled contract
 *
 *      This contract implements inherits access control upgradeable contract,
 *      in which provides a role based access control (RBAC) for admin priveleges.
 *      It also provides other privileges such as:
 *      - Pausing the contract
 *      - Delegating contract calls to trusted targets (only managed by the default admin role)
 *      - Changing state variable value using its storage slot
 *      - Role management using AccessControlled ABIs
 */
contract AdminControlled is UUPSUpgradeable, AccessControlUpgradeable {
    uint256 public paused;
    bytes32 public constant PAUSE_ROLE = keccak256("PAUSE_ROLE");

    modifier pausable(uint256 flag) {
        require(
            (paused & flag) == 0 || hasRole(DEFAULT_ADMIN_ROLE, msg.sender),
            "CONTRACT_IS_PAUSED"
        );
        _;
    }

    /// @dev __AdminControlled_init initializes this contract, setting pause flags
    /// and granting admin and pause roles.
    /// @param _flags flags variable will be used for pausing this contract.
    /// the default flags value is zero.
    function __AdminControlled_init(uint256 _flags) internal {
        __UUPSUpgradeable_init();
        __AccessControl_init();
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(PAUSE_ROLE, msg.sender);
        paused = _flags;
    }

    /// @dev adminPause pauses this contract. Only pause role or default
    /// admin role can access this function.
    /// @param flags flags variable is used for pausing this contract.
    function adminPause(uint256 flags) external onlyRole(PAUSE_ROLE) {
        // pause role can pause the contract, however only default admin role can unpause
        require(
            (paused & flags) == paused ||
                hasRole(DEFAULT_ADMIN_ROLE, msg.sender),
            "ONLY_DEFAULT_ADMIN_CAN_UNPAUSE"
        );
        paused = flags;
    }

    /// @dev adminSstore updates the state variable value.
    /// only default admin role can call this function.
    /// @param key is the storage slot of the state variable
    /// @param value is the state variable value
    function adminSstore(uint256 key, uint256 value)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        assembly {
            sstore(key, value)
        }
    }

    /// @dev adminSstoreWithMask similar to adminSstore except
    /// it updates the state variable value after xor-ing this value
    /// with the old value and the mask, so the new value should be
    /// a result of xor(and(xor(value, oldval), mask), oldval).
    /// Only default admin role can call this function.
    /// @param key is the storage slot of the state variable
    /// @param value is the state variable value
    /// @param mask this value is used in calculating the new value
    function adminSstoreWithMask(
        uint256 key,
        uint256 value,
        uint256 mask
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        assembly {
            let oldval := sload(key)
            sstore(key, xor(and(xor(value, oldval), mask), oldval))
        }
    }

    /// @dev adminDelegatecall allows this contract to delegate calls
    /// to a target contract and execute it in the context of this
    /// contract. Only default admin role can call this function.
    /// @param target the target contract address
    /// @param data is the ABI encoded function signature and its values.
    /// @custom:oz-upgrades-unsafe-allow delegatecall
    function adminDelegatecall(address target, bytes memory data)
        external
        payable
        onlyRole(DEFAULT_ADMIN_ROLE)
        returns (bytes memory)
    {
        require(target != address(0), "ZERO_ADDRESS");
        (bool success, bytes memory rdata) = target.delegatecall(data);
        require(success);
        return rdata;
    }

    ///@dev required by the OZ UUPS module
    function _authorizeUpgrade(address)
        internal
        override
        onlyRole(DEFAULT_ADMIN_ROLE)
    {}
}


// File @openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20Upgradeable {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


// File @openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (token/ERC20/utils/SafeERC20.sol)

pragma solidity ^0.8.0;


/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20Upgradeable {
    using AddressUpgradeable for address;

    function safeTransfer(
        IERC20Upgradeable token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20Upgradeable token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20Upgradeable token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        IERC20Upgradeable token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        IERC20Upgradeable token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20Upgradeable token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}


// File contracts/JetStakingV2.sol

pragma solidity 0.8.10;




/**
 * @title JetStakingV2
 * @author Aurora Team
 *
 * @dev Implementation of Jet staking contract
 *
 *      This contract implements the staking mechanics for AURORA ERC20 token.
 *      A user can stake any amount of AURORA tokens, and get rewarded in both
 *      AURORA and other stream tokens based on the rewards schedules.
 *      Stream rewards can be claimed any time however AURORA can't be claimed
 *      unless the user unstakes his full/partial amount of shares.
 *
 *      This contract is AdminControlled which has a tremendous power. However
 *      hopfully it be governed by a community wallet.
 */
contract JetStakingV2 is AdminControlled {
    using SafeERC20Upgradeable for IERC20Upgradeable;
    bytes32 public constant AIRDROP_ROLE = keccak256("AIRDROP_ROLE");
    bytes32 public constant CLAIM_ROLE = keccak256("CLAIM_ROLE");
    bytes32 public constant STREAM_MANAGER_ROLE =
        keccak256("STREAM_MANAGER_ROLE");
    uint256 public constant ONE_MONTH = 2629746;
    uint256 public constant FOUR_YEARS = 126227808;
    // RPS_MULTIPLIER = Aurora_max_supply x weight(1000) * 10 (large enough to always release rewards) =
    // 10**9 * 10**18 * 10**3 * 10= 10**31
    uint256 private constant RPS_MULTIPLIER = 1e31;
    uint256 public totalAmountOfStakedAurora;
    uint256 public touchedAt;
    uint256 public totalAuroraShares;
    uint256 public totalStreamShares;
    address public treasury;
    address public auroraToken;
    uint256 public maxWeight;
    uint256 public minWeight;

    enum StreamStatus {
        INACTIVE,
        PROPOSED,
        ACTIVE
    }

    struct User {
        uint256 deposit;
        uint256 auroraShares;
        uint256 streamShares;
        mapping(uint256 => uint256) pendings; // The amount of tokens pending release for user per stream
        mapping(uint256 => uint256) releaseTime; // The release moment per stream
        mapping(uint256 => uint256) rpsDuringLastClaim; // RPS or reward per share during the previous rewards claim
    }

    struct Schedule {
        uint256[] time;
        uint256[] reward;
    }

    struct Stream {
        address owner; // stream owned by the ERC-20 reward token owner
        address manager; // stream manager handled by AURORA stream manager role
        address rewardToken;
        uint256 auroraDepositAmount;
        uint256 auroraClaimedAmount;
        uint256 rewardDepositAmount;
        uint256 rewardClaimedAmount;
        uint256 maxDepositAmount;
        uint256 minDepositAmount;
        uint256 lastTimeOwnerClaimed;
        uint256 tau; // pending time prior reward release
        uint256 rps; // Reward per share for a stream j>0
        Schedule schedule;
        StreamStatus status;
    }

    mapping(address => User) public users;
    Stream[] streams;

    // events
    event Staked(address indexed user, uint256 amount, uint256 shares);

    event Unstaked(address indexed user, uint256 amount);

    event Pending(
        uint256 indexed streamId,
        address indexed user,
        uint256 amount
    );

    event Released(
        uint256 indexed streamId,
        address indexed user,
        uint256 amount
    );

    event StreamOwnerRewardReleased(
        uint256 indexed streamId,
        address indexed owner,
        uint256 amount
    );

    event StreamProposed(
        uint256 indexed streamId,
        address indexed owner,
        address indexed token,
        uint256 maxDepositAmount,
        uint256 auroraDepositAmount
    );

    event StreamProposalCancelled(
        uint256 indexed streamId,
        address indexed owner,
        address indexed token
    );

    event StreamCreated(
        uint256 indexed streamId,
        address indexed owner,
        address indexed token,
        uint256 tokenAmount,
        uint256 auroraAmount
    );

    event StreamRemoved(
        uint256 indexed streamId,
        address indexed owner,
        address indexed token
    );

    modifier onlyValidSharesAmount() {
        require(
            totalAuroraShares != 0 && users[msg.sender].auroraShares != 0,
            "E1" //ZERO_USER_SHARES
        );
        _;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    /// @dev initialize the contract and deploys the first stream (AURORA)
    /// @notice By calling this function, the deployer of this contract must
    /// make sure that the AURORA reward amount was deposited to the treasury
    /// contract before initializing of the default AURORA stream.
    /// @param aurora token contract address
    /// @param scheduleTimes init the schedule time
    /// @param scheduleRewards init the schedule amounts
    /// @param tauAuroraStream release time constant per stream (e.g AURORA stream)
    /// @param _flags admin controlled contract flags
    /// @param _treasury the Aurora treasury contract address
    /// @param _maxWeight max stream reward weighting coefficient
    /// @param _minWeight min stream reward weighting coefficient
    function initialize(
        address aurora,
        address streamOwner,
        uint256[] memory scheduleTimes,
        uint256[] memory scheduleRewards,
        uint256 tauAuroraStream,
        uint256 _flags,
        address _treasury,
        uint256 _maxWeight,
        uint256 _minWeight
    ) external initializer {
        require(_maxWeight > _minWeight, "E3"); //INVALID_WEIGHTS
        require(_treasury != address(0), "E4"); //INVALID_ADDRESS
        _validateStreamParameters(
            streamOwner,
            aurora,
            scheduleRewards[0],
            scheduleRewards[0],
            scheduleTimes,
            scheduleRewards,
            tauAuroraStream
        );
        // check aurora token address is supportedToken in the treasury
        require(ITreasury(_treasury).isSupportedToken(aurora), "E5"); // INVALID_SUPPORTED_TOKEN_ADDRESS
        __AdminControlled_init(_flags);
        _grantRole(AIRDROP_ROLE, msg.sender);
        _grantRole(CLAIM_ROLE, msg.sender);
        _grantRole(STREAM_MANAGER_ROLE, msg.sender);
        treasury = _treasury;
        auroraToken = aurora;
        maxWeight = _maxWeight;
        minWeight = _minWeight;
        //init AURORA default stream
        // This is a special stream where the reward token is the aurora token itself.
        uint256 streamId = 0;
        Schedule memory schedule = Schedule(scheduleTimes, scheduleRewards);
        streams.push(
            Stream({
                owner: streamOwner,
                manager: streamOwner,
                rewardToken: aurora,
                auroraDepositAmount: 0,
                auroraClaimedAmount: 0,
                maxDepositAmount: 0,
                minDepositAmount: 0,
                rewardDepositAmount: 0,
                rewardClaimedAmount: 0,
                lastTimeOwnerClaimed: block.timestamp,
                schedule: schedule,
                status: StreamStatus.ACTIVE,
                tau: tauAuroraStream,
                rps: 0
            })
        );
        emit StreamProposed(
            streamId,
            streamOwner,
            aurora,
            scheduleRewards[0],
            scheduleRewards[0]
        );
        emit StreamCreated(
            streamId,
            streamOwner,
            aurora,
            scheduleRewards[0],
            scheduleRewards[0]
        );
    }

    /// @dev An admin of the staking contract can whitelist (propose) a stream.
    /// Whitelisting of the stream provides the option for the stream
    /// owner (presumably the issuing party of a specific token) to
    /// deposit some ERC-20 tokens on the staking contract and potentially
    /// get in return some AURORA tokens. Deposited ERC-20 tokens will be
    /// distributed to the stakers over some period of time.
    /// @notice treasury manager must call
    /// @param streamOwner only this account would be able to create a stream
    /// @param rewardToken the address of the ERC-20 tokens to be deposited in the stream
    /// @param auroraDepositAmount Amount of the AURORA deposited by the Admin.
    /// @param maxDepositAmount The upper amount of the tokens that should be deposited by the stream owner
    /// @param scheduleTimes timestamp denoting the start of each scheduled interval. Last element is the end of the stream.
    /// @param scheduleRewards remaining rewards to be delivered at the beginning of each scheduled interval. Last element is always zero.
    /// First value (in scheduleRewards) from array is supposed to be a total amount of rewards for stream.
    /// @param tau the tau is (pending release period) for this stream (e.g one day)
    function proposeStream(
        address streamOwner,
        address rewardToken,
        uint256 auroraDepositAmount,
        uint256 maxDepositAmount,
        uint256 minDepositAmount,
        uint256[] memory scheduleTimes,
        uint256[] memory scheduleRewards,
        uint256 tau
    ) external virtual onlyRole(STREAM_MANAGER_ROLE) {
        _validateStreamParameters(
            streamOwner,
            rewardToken,
            maxDepositAmount,
            minDepositAmount,
            scheduleTimes,
            scheduleRewards,
            tau
        );
        // check aurora token address is supportedToken in the treasury
        require(ITreasury(treasury).isSupportedToken(rewardToken), "E6"); //INVALID_SUPPORTED_TOKEN_ADDRESS
        Schedule memory schedule = Schedule(scheduleTimes, scheduleRewards);
        uint256 streamId = streams.length;
        streams.push(
            Stream({
                owner: streamOwner,
                manager: msg.sender,
                rewardToken: rewardToken,
                auroraDepositAmount: auroraDepositAmount,
                auroraClaimedAmount: 0,
                maxDepositAmount: maxDepositAmount,
                minDepositAmount: minDepositAmount,
                rewardDepositAmount: 0,
                rewardClaimedAmount: 0,
                lastTimeOwnerClaimed: scheduleTimes[0],
                schedule: schedule,
                status: StreamStatus.PROPOSED,
                tau: tau,
                rps: 0
            })
        );
        emit StreamProposed(
            streamId,
            streamOwner,
            rewardToken,
            maxDepositAmount,
            auroraDepositAmount
        );
        IERC20Upgradeable(auroraToken).safeTransferFrom(
            msg.sender,
            address(this),
            auroraDepositAmount
        );
    }

    /// @dev cancelStreamProposal cancels a proposal any time before the stream
    /// becomes active (created).
    /// @param streamId the stream index
    function cancelStreamProposal(uint256 streamId)
        external
        virtual
        onlyRole(STREAM_MANAGER_ROLE)
    {
        Stream storage stream = streams[streamId];
        require(stream.status == StreamStatus.PROPOSED, "E7"); //STREAM_NOT_PROPOSED
        // cancel the proposal
        stream.status = StreamStatus.INACTIVE;
        uint256 refundAmount = stream.auroraDepositAmount;
        stream.auroraDepositAmount = 0;
        emit StreamProposalCancelled(
            streamId,
            stream.owner,
            stream.rewardToken
        );
        // refund stream manager wallet with the stream aurora deposit
        IERC20Upgradeable(auroraToken).safeTransfer(
            stream.manager,
            refundAmount
        );
    }

    /// @dev create new stream (only stream owner)
    /// stream owner must approve reward tokens to this contract.
    /// @param streamId stream id
    function createStream(uint256 streamId, uint256 rewardTokenAmount)
        external
        virtual
        pausable(1)
    {
        Stream storage stream = streams[streamId];
        require(stream.status == StreamStatus.PROPOSED, "E8"); // STREAM_NOT_PROPOSED
        require(stream.owner == msg.sender, "E9"); // INVALID_STREAM_OWNER
        require(stream.schedule.time[0] >= block.timestamp, "E10"); // STREAM_PROPOSAL_EXPIRED
        require(rewardTokenAmount <= stream.maxDepositAmount, "E11"); // REWARD_TOO_HIGH
        require(rewardTokenAmount >= stream.minDepositAmount, "E12"); // REWARD_TOO_LOW
        stream.status = StreamStatus.ACTIVE;
        stream.rewardDepositAmount = rewardTokenAmount;
        if (rewardTokenAmount < stream.maxDepositAmount) {
            // refund staking admin if deposited reward tokens less than the upper limit of deposit
            uint256 newAuroraDepositAmount = (rewardTokenAmount *
                stream.auroraDepositAmount) / stream.maxDepositAmount;
            uint256 refundAuroraAmount = stream.auroraDepositAmount -
                newAuroraDepositAmount;
            stream.auroraDepositAmount = newAuroraDepositAmount;
            // update stream reward schedules
            _updateStreamRewardSchedules(streamId, rewardTokenAmount);
            IERC20Upgradeable(auroraToken).safeTransfer(
                stream.manager,
                refundAuroraAmount
            );
        }
        emit StreamCreated(
            streamId,
            stream.owner,
            stream.rewardToken,
            rewardTokenAmount,
            stream.auroraDepositAmount
        );
        require(stream.schedule.reward[0] == stream.rewardDepositAmount, "E13"); // INVALID_STARTING_REWARD
        // move Aurora tokens to treasury
        IERC20Upgradeable(auroraToken).safeTransfer(
            address(treasury),
            stream.auroraDepositAmount
        );
        // move reward tokens to treasury
        IERC20Upgradeable(stream.rewardToken).safeTransferFrom(
            msg.sender,
            address(treasury),
            rewardTokenAmount
        );
    }

    /// @dev Get the treasury balance
    /// @param token the token address
    function getTreasuryBalance(address token)
        public
        view
        virtual
        returns (uint256)
    {
        return IERC20Upgradeable(token).balanceOf(treasury);
    }

    /// @dev removes a stream (only default admin role)
    /// @param streamId stream index
    /// @param streamFundReceiver receives the rest of the reward tokens in the stream
    function removeStream(uint256 streamId, address streamFundReceiver)
        external
        virtual
        onlyRole(STREAM_MANAGER_ROLE)
    {
        require(streamId != 0, "E14"); // AURORA_STREAM_NOT_REMOVABLE
        Stream storage stream = streams[streamId];
        require(stream.status == StreamStatus.ACTIVE, "E15"); // STREAM_ALREADY_REMOVED
        stream.status = StreamStatus.INACTIVE;
        emit StreamRemoved(streamId, stream.owner, stream.rewardToken);
        uint256 releaseAuroraAmount = stream.auroraDepositAmount -
            stream.auroraClaimedAmount;
        uint256 releaseRewardAmount = stream.rewardDepositAmount -
            stream.rewardClaimedAmount;
        // check enough treasury balance
        uint256 auroraTreasury = getTreasuryBalance(auroraToken);
        uint256 rewardTreasury = getTreasuryBalance(stream.rewardToken);
        // move rest of the unclaimed aurora to the stream manager
        ITreasury(treasury).payRewards(
            stream.manager,
            auroraToken,
            releaseAuroraAmount <= auroraTreasury
                ? releaseAuroraAmount
                : auroraTreasury // should not happen
        );
        // move the rest of rewards to the stream owner
        ITreasury(treasury).payRewards(
            streamFundReceiver,
            stream.rewardToken,
            releaseRewardAmount <= rewardTreasury
                ? releaseRewardAmount
                : rewardTreasury // should not happen
        );
    }

    /// @dev extend Aurora stream reward schedule. It can be only called by the default
    /// contract admin. It can accept extending the schedule if the new schedule is
    /// not overlapping with the current schedule. Also, it requires to pause the contract before calling it.
    /// @param scheduleTimes timestamp denoting the start of each scheduled interval. Last element is the end of the stream.
    /// @param scheduleRewards remaining rewards to be delivered at the beginning of each scheduled interval. Last element is always zero.
    function extendAuroraStreamSchedule(
        uint256[] memory scheduleTimes,
        uint256[] memory scheduleRewards
    ) external virtual onlyRole(DEFAULT_ADMIN_ROLE) {
        require(paused != 0, "E16"); // REQUIRE_PAUSE
        Stream storage stream = streams[0];
        // requires ending the current stream in order to extend it.
        // This will avoid mixing old and new rewards.
        require(
            scheduleTimes[0] ==
                stream.schedule.time[stream.schedule.time.length - 1],
            "E17" // INVALID_SCHEDULE_START_TIME
        );
        // validate stream schedule
        _validateStreamSchedule(
            scheduleRewards[0],
            scheduleTimes,
            scheduleRewards
        );
        // move rewards to the treasury
        IERC20Upgradeable(stream.rewardToken).safeTransferFrom(
            msg.sender,
            address(treasury),
            scheduleRewards[0]
        );
        // Delete the last schedule element
        // The last element will be replaced by
        // the first element in the new schedule.
        stream.schedule.time.pop();
        stream.schedule.reward.pop();
        // make the schedule rewards consistent.
        for (uint256 i = 0; i < stream.schedule.time.length; i++) {
            stream.schedule.reward[i] += scheduleRewards[0];
        }
        // extend Aurora stream schedule.
        for (uint256 i = 0; i < scheduleTimes.length; i++) {
            stream.schedule.time.push(scheduleTimes[i]);
            stream.schedule.reward.push(scheduleRewards[i]);
        }
    }

    /// @dev Stream owner claimable AURORA.
    /// @param streamId the stream index
    function getStreamOwnerClaimableAmount(uint256 streamId)
        public
        view
        virtual
        returns (uint256)
    {
        Stream storage stream = streams[streamId];
        if (stream.status != StreamStatus.ACTIVE) return 0;
        uint256 scheduledReward = getRewardsAmount(
            streamId,
            stream.lastTimeOwnerClaimed
        );
        return
            (scheduledReward * stream.auroraDepositAmount) /
            stream.rewardDepositAmount;
    }

    /// @dev the release of AURORA tokens to the stream owner is subjected to the same schedule as rewards.
    /// Thus if for a specific moment in time 30% of the rewards are distributed, then it means that 30% of
    /// the AURORA deposit can be withdrawn by the stream owner too.
    /// called by the stream owner
    /// @param streamId the stream index
    function releaseAuroraRewardsToStreamOwner(uint256 streamId)
        external
        virtual
        pausable(1)
    {
        require(streamId != 0, "E18"); // AURORA_STREAM_NA
        Stream storage stream = streams[streamId];
        require(msg.sender == stream.owner, "E19"); // INVALID_STREAM_OWNER
        require(stream.status == StreamStatus.ACTIVE, "E20"); // INACTIVE_OR_PROPOSED_STREAM
        uint256 auroraStreamOwnerReward = getStreamOwnerClaimableAmount(
            streamId
        );
        require(auroraStreamOwnerReward > 0, "E21"); // ZERO_REWARDS
        stream.lastTimeOwnerClaimed = block.timestamp;
        stream.auroraClaimedAmount += auroraStreamOwnerReward;
        // check enough treasury balance
        emit StreamOwnerRewardReleased(
            streamId,
            stream.owner,
            auroraStreamOwnerReward
        );
        ITreasury(treasury).payRewards(
            stream.owner,
            auroraToken,
            auroraStreamOwnerReward
        );
    }

    /// @dev get the stream data
    /// @notice this function doesn't return the stream
    /// schedule due to some stake slots limitations. To
    /// get the stream schedule, refer to getStreamSchedule
    /// @param streamId the stream index
    function getStream(uint256 streamId)
        external
        view
        virtual
        returns (
            address streamOwner,
            address rewardToken,
            uint256 auroraDepositAmount,
            uint256 auroraClaimedAmount,
            uint256 rewardDepositAmount,
            uint256 rewardClaimedAmount,
            uint256 maxDepositAmount,
            uint256 lastTimeOwnerClaimed,
            uint256 rps,
            uint256 tau,
            StreamStatus status
        )
    {
        Stream storage stream = streams[streamId];
        return (
            stream.owner,
            stream.rewardToken,
            stream.auroraDepositAmount,
            stream.auroraClaimedAmount,
            stream.rewardDepositAmount,
            stream.rewardClaimedAmount,
            stream.maxDepositAmount,
            stream.lastTimeOwnerClaimed,
            stream.rps,
            stream.tau,
            stream.status
        );
    }

    /// @dev get the stream schedule data
    /// @param streamId the stream index
    function getStreamSchedule(uint256 streamId)
        external
        view
        virtual
        returns (
            uint256[] memory scheduleTimes,
            uint256[] memory scheduleRewards
        )
    {
        return (
            streams[streamId].schedule.time,
            streams[streamId].schedule.reward
        );
    }

    /// @dev get the streams count
    /// @return streams.length
    function getStreamsCount() external view virtual returns (uint256) {
        return streams.length;
    }

    /// @notice updates treasury account
    /// @dev restricted for the admin only. Admin should pause this
    /// contract before changing the treasury address by setting the
    /// pause =1 (for changing this variable, call adminPause(1))
    /// @param _treasury treasury contract address for the reward tokens
    function updateTreasury(address _treasury)
        external
        virtual
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        // enforce pausing this contract before updating the address.
        // This mitigates the risk of future invalid reward claims
        require(paused != 0, "E16"); // REQUIRE_PAUSE
        require(_treasury != address(0) && _treasury != treasury, "E4"); // INVALID_ADDRESS
        treasury = _treasury;
    }

    /// @dev stakeOnBehalfOfAnotherUser is called for airdropping Aurora users
    /// @param account the account address
    /// @param amount in AURORA tokens
    /// WARNING: rewards are not claimed during stake. Airdrop script must claim or
    /// only distribute to accounts without stake
    function stakeOnBehalfOfAnotherUser(address account, uint256 amount)
        external
        virtual
        pausable(1)
        onlyRole(AIRDROP_ROLE)
    {
        _before();
        _stake(account, amount);
        IERC20Upgradeable(auroraToken).safeTransferFrom(
            msg.sender,
            address(treasury),
            amount
        );
    }

    /// @dev moves the reward for specific stream Id to pending rewards.
    /// It will require a waiting time untill it get released. Users call
    /// this in function in order to claim rewards.
    /// @param streamId stream index
    function moveRewardsToPending(uint256 streamId)
        external
        virtual
        pausable(1)
    {
        _before();
        _moveRewardsToPending(msg.sender, streamId);
    }

    /// @dev moves all the user rewards to pending reward.
    function moveAllRewardsToPending() external virtual pausable(1) {
        _before();
        // Claim all streams while skipping inactive streams.
        _moveAllRewardsToPending(msg.sender);
    }

    /// @dev moves a set of stream Id rewards to pending.
    /// Allows user to select stream ids to claim from UI.
    /// @param streamIds stream indexes
    function batchMoveRewardsToPending(uint256[] calldata streamIds)
        external
        virtual
        pausable(1)
    {
        _before();
        _batchClaimRewards(msg.sender, streamIds);
    }

    /// @dev Claim all stream rewards on behalf of another user.
    /// @param account the user account address.
    function claimAllOnBehalfOfAnotherUser(address account)
        external
        virtual
        pausable(1)
        onlyRole(CLAIM_ROLE)
    {
        _before();
        _moveAllRewardsToPending(account);
    }

    /// @dev batchClaimOnBehalfOfAnotherUser when gas limits prevent users from claiming all.
    /// @param account the user account address.
    /// @param streamIds to claim.
    function batchClaimOnBehalfOfAnotherUser(
        address account,
        uint256[] calldata streamIds
    ) external virtual pausable(1) onlyRole(CLAIM_ROLE) {
        _before();
        _batchClaimRewards(account, streamIds);
    }

    /// @dev a user stakes amount of AURORA tokens
    /// The user should approve these tokens to the treasury
    /// contract in order to complete the stake.
    /// @param amount is the AURORA amount.
    function stake(uint256 amount) external virtual pausable(1) {
        _before();
        _stake(msg.sender, amount);
        IERC20Upgradeable(auroraToken).safeTransferFrom(
            msg.sender,
            address(treasury),
            amount
        );
    }

    /// @dev withdraw amount in the pending pool. User should wait for
    /// pending time (tau constant) in order to be able to withdraw.
    /// @param streamId stream index
    function withdraw(uint256 streamId) external virtual pausable(1) {
        require(
            block.timestamp > users[msg.sender].releaseTime[streamId],
            "E27" // INVALID_RELEASE_TIME
        );
        _withdraw(streamId);
    }

    /// @dev withdraw all claimed balances which have passed pending periode.
    /// This function will reach gas limit with too many streams,
    /// so the frontend will allow individual stream withdrawals and disable withdrawAll.
    function withdrawAll() external virtual pausable(1) {
        User storage userAccount = users[msg.sender];
        uint256 streamsLength = streams.length;
        for (uint256 i = 0; i < streamsLength; i++) {
            if (
                userAccount.pendings[i] != 0 &&
                block.timestamp > userAccount.releaseTime[i]
            ) {
                _withdraw(i);
            }
        }
    }

    /// @dev withdraw a set of stream Ids.
    /// Allows user to select stream ids to withdraw from UI.
    /// @param streamIds to withdraw.
    function batchWithdraw(uint256[] calldata streamIds)
        external
        virtual
        pausable(1)
    {
        User storage userAccount = users[msg.sender];
        for (uint256 i = 0; i < streamIds.length; i++) {
            if (
                userAccount.pendings[streamIds[i]] != 0 &&
                block.timestamp > userAccount.releaseTime[streamIds[i]]
            ) {
                _withdraw(streamIds[i]);
            }
        }
    }

    /// @dev gets the total user deposit
    /// @param account the user address
    /// @return user total deposit in (AURORA)
    function getUserTotalDeposit(address account)
        external
        view
        virtual
        returns (uint256)
    {
        return users[account].deposit;
    }

    /// @dev gets the user shares
    /// @param account the user address
    /// @return user shares
    function getUserShares(address account)
        external
        view
        virtual
        returns (uint256)
    {
        return users[account].auroraShares;
    }

    /// @dev unstake amount from user shares value. The rest is re-staked
    /// @param amount to unstake
    function unstake(uint256 amount)
        external
        virtual
        pausable(1)
        onlyValidSharesAmount
    {
        _before();
        uint256 stakeValue = (totalAmountOfStakedAurora *
            users[msg.sender].auroraShares) / totalAuroraShares;
        _unstake(amount, stakeValue);
    }

    /// @dev unstake all the user's shares
    function unstakeAll() external virtual pausable(1) onlyValidSharesAmount {
        _before();
        uint256 stakeValue = (totalAmountOfStakedAurora *
            users[msg.sender].auroraShares) / totalAuroraShares;
        _unstake(stakeValue, stakeValue);
    }

    /// @dev gets a user stream shares
    /// @param streamId stream index
    /// @param account the user address
    /// @return user stream shares
    function getAmountOfShares(uint256 streamId, address account)
        external
        view
        virtual
        returns (uint256)
    {
        if (streamId == 0) return users[account].auroraShares;
        return users[account].streamShares;
    }

    /// @dev gets reward per share (RPS) for a stream
    /// @param streamId stream index
    /// @return streams[streamId].rps
    function getRewardPerShare(uint256 streamId)
        external
        view
        virtual
        returns (uint256)
    {
        return streams[streamId].rps;
    }

    /// @dev calculates and gets the latest released rewards.
    /// @param streamId stream index
    /// @return rewards released since last update.
    function getRewardsAmount(uint256 streamId, uint256 lastUpdate)
        public
        view
        virtual
        returns (uint256)
    {
        uint256 currentTimestamp = block.timestamp;
        require(lastUpdate <= currentTimestamp, "E28"); // INVALID_LAST_UPDATE
        if (lastUpdate == currentTimestamp) return 0; // No more rewards since last update
        uint256 streamStart = streams[streamId].schedule.time[0];
        if (currentTimestamp <= streamStart) return 0; // Stream didn't start
        uint256 streamEnd = streams[streamId].schedule.time[
            streams[streamId].schedule.time.length - 1
        ];
        if (lastUpdate >= streamEnd) return 0; // Stream schedule ended, all rewards released
        uint256 start;
        uint256 end;
        if (lastUpdate > streamStart) {
            start = lastUpdate;
        } else {
            // Release rewards from stream start.
            start = streamStart;
        }
        if (currentTimestamp < streamEnd) {
            end = currentTimestamp;
        } else {
            // The stream already finished between the last update and now.
            end = streamEnd;
        }
        return rewardsSchedule(streamId, start, end);
    }

    /// @dev calculates and gets the latest reward per share (RPS) for a stream
    /// @param streamId stream index
    /// @return streams[streamId].rps + scheduled reward up till now
    function getLatestRewardPerShare(uint256 streamId)
        public
        view
        virtual
        returns (uint256)
    {
        require(streamId != 0, "E29"); // AURORA_REWARDS_COMPOUND
        require(totalStreamShares != 0, "E30"); // ZERO_STREAM_SHARES
        return
            streams[streamId].rps +
            (getRewardsAmount(streamId, touchedAt) * RPS_MULTIPLIER) /
            totalStreamShares;
    }

    /// @dev gets the user's reward per share (RPS) for a stream
    /// @param streamId stream index
    /// @return user.rpsDuringLastClaim[streamId]
    function getRewardPerShareForUser(uint256 streamId, address account)
        external
        view
        virtual
        returns (uint256)
    {
        return users[account].rpsDuringLastClaim[streamId];
    }

    /// @dev gets the user's stream claimable amount
    /// @param streamId stream index
    /// @return (latesRPS - user.rpsDuringLastClaim) * user.shares
    function getStreamClaimableAmount(uint256 streamId, address account)
        external
        view
        virtual
        returns (uint256)
    {
        uint256 latestRps = getLatestRewardPerShare(streamId);
        User storage userAccount = users[account];
        uint256 userRps = userAccount.rpsDuringLastClaim[streamId];
        uint256 userShares = userAccount.streamShares;
        return ((latestRps - userRps) * userShares) / RPS_MULTIPLIER;
    }

    /// @dev gets the user's stream pending reward
    /// @param streamId stream index
    /// @param account user account
    /// @return user.pendings[streamId]
    function getPending(uint256 streamId, address account)
        external
        view
        virtual
        returns (uint256)
    {
        return users[account].pendings[streamId];
    }

    /// @dev gets the user's stream reward release time
    /// @param streamId stream index
    /// @param account user account
    /// @return user.releaseTime[streamId]
    function getReleaseTime(uint256 streamId, address account)
        external
        view
        virtual
        returns (uint256)
    {
        return users[account].releaseTime[streamId];
    }

    /// @dev gets the total amount of staked aurora
    /// @return totalAmountOfStakedAurora + latest reward schedule
    function getTotalAmountOfStakedAurora() external view returns (uint256) {
        if (touchedAt == 0) return 0;
        return totalAmountOfStakedAurora + getRewardsAmount(0, touchedAt);
    }

    /// @dev gets start index and end index in a stream schedule
    /// @param streamId stream index
    /// @param start start time (in seconds)
    /// @param end end time (in seconds)
    function startEndScheduleIndex(
        uint256 streamId,
        uint256 start,
        uint256 end
    ) public view returns (uint256 startIndex, uint256 endIndex) {
        Schedule storage schedule = streams[streamId].schedule;
        uint256 scheduleTimeLength = schedule.time.length;
        require(scheduleTimeLength > 0, "E31"); // NO_SCHEDULE
        require(end > start, "E32"); // INVALID_REWARD_QUERY_PERIOD
        require(start >= schedule.time[0], "E33"); // QUERY_BEFORE_SCHEDULE_START
        require(end <= schedule.time[scheduleTimeLength - 1], "E34"); // QUERY_AFTER_SCHEDULE_END
        // find start index
        for (uint256 i = 1; i < scheduleTimeLength; i++) {
            if (start < schedule.time[i]) {
                startIndex = i - 1;
                break;
            }
        }
        // find end index
        if (end == schedule.time[scheduleTimeLength - 1]) {
            endIndex = scheduleTimeLength - 2;
        } else {
            for (uint256 i = startIndex + 1; i < scheduleTimeLength; i++) {
                if (end < schedule.time[i]) {
                    // Users most often claim rewards within the same index which can last several months.
                    endIndex = i - 1;
                    break;
                }
            }
        }
        require(startIndex <= endIndex, "E35"); // INVALID_INDEX_CALCULATION
    }

    /// @dev calculate the total amount of the released tokens within a period (start & end)
    /// @param streamId the stream index
    /// @param start is the start timestamp within the schedule
    /// @param end is the end timestamp (e.g block.timestamp .. now)
    /// @return amount of the released tokens for that period
    function rewardsSchedule(
        uint256 streamId,
        uint256 start,
        uint256 end
    ) public view virtual returns (uint256) {
        Schedule storage schedule = streams[streamId].schedule;
        uint256 startIndex;
        uint256 endIndex;
        (startIndex, endIndex) = startEndScheduleIndex(streamId, start, end);
        uint256 rewardScheduledAmount = 0;
        uint256 reward = 0;
        if (startIndex == endIndex) {
            // start and end are within the same schedule period
            reward =
                schedule.reward[startIndex] -
                schedule.reward[startIndex + 1];
            rewardScheduledAmount =
                (reward * (end - start)) /
                (schedule.time[startIndex + 1] - schedule.time[startIndex]);
        } else {
            // start and end are not within the same schedule period
            // Reward during the startIndex period
            reward =
                schedule.reward[startIndex] -
                schedule.reward[startIndex + 1];
            rewardScheduledAmount =
                (reward * (schedule.time[startIndex + 1] - start)) /
                (schedule.time[startIndex + 1] - schedule.time[startIndex]);
            // Reward during the period from startIndex + 1  to endIndex - 1
            rewardScheduledAmount +=
                schedule.reward[startIndex + 1] -
                schedule.reward[endIndex];
            // Reward during the endIndex period
            reward = schedule.reward[endIndex] - schedule.reward[endIndex + 1];
            rewardScheduledAmount +=
                (reward * (end - schedule.time[endIndex])) /
                (schedule.time[endIndex + 1] - schedule.time[endIndex]);
        }
        return rewardScheduledAmount;
    }

    /// @dev called before touching the contract reserves (stake/unstake)
    function _before() internal {
        if (touchedAt == block.timestamp) return; // Already updated by previous tx in same block.
        if (totalAuroraShares != 0) {
            // Don't release rewards if there are no stakers.
            totalAmountOfStakedAurora += getRewardsAmount(0, touchedAt);
            uint256 streamsLength = streams.length;
            for (uint256 i = 1; i < streamsLength; i++) {
                if (streams[i].status == StreamStatus.ACTIVE) {
                    // If stream becomes blacklisted, no more rewards are released.
                    streams[i].rps = getLatestRewardPerShare(i);
                }
            }
        }
        touchedAt = block.timestamp;
    }

    /// @dev calculate the weighted stream shares at given timeshamp.
    /// @param timestamp the timestamp refering to the current or older timestamp
    function _weightedShares(uint256 shares, uint256 timestamp)
        internal
        view
        virtual
        returns (uint256)
    {
        uint256 slopeStart = streams[0].schedule.time[0] + ONE_MONTH;
        uint256 slopeEnd = slopeStart + FOUR_YEARS;
        if (timestamp <= slopeStart) return shares * maxWeight;
        if (timestamp >= slopeEnd) return shares * minWeight;
        return
            shares *
            minWeight +
            (shares * (maxWeight - minWeight) * (slopeEnd - timestamp)) /
            (slopeEnd - slopeStart);
    }

    /// @dev allocate the collected reward to the pending tokens
    /// Rewards will become withdrawable after the release time.
    /// @param account is the staker address
    /// @param streamId the stream index
    function _moveRewardsToPending(address account, uint256 streamId)
        internal
        virtual
    {
        require(streamId != 0, "E36"); // AURORA_REWARDS_COMPOUND
        require(streams[streamId].status == StreamStatus.ACTIVE, "E37"); // INACTIVE_OR_PROPOSED_STREAM
        User storage userAccount = users[account];
        require(userAccount.auroraShares != 0, "E38"); // USER_DOES_NOT_HAVE_ACTUAL_STAKE
        uint256 reward = ((streams[streamId].rps -
            userAccount.rpsDuringLastClaim[streamId]) *
            userAccount.streamShares) / RPS_MULTIPLIER;
        if (reward == 0) return; // All rewards claimed or stream schedule didn't start
        userAccount.pendings[streamId] += reward;
        userAccount.rpsDuringLastClaim[streamId] = streams[streamId].rps;
        userAccount.releaseTime[streamId] =
            block.timestamp +
            streams[streamId].tau;
        // If the stream is blacklisted, remaining unclaimed rewards will be transfered out.
        streams[streamId].rewardClaimedAmount += reward;
        emit Pending(streamId, account, userAccount.pendings[streamId]);
    }

    /// @dev move all the streams rewards for a user to the pending tokens
    /// @param account is the staker address
    function _moveAllRewardsToPending(address account) internal virtual {
        uint256 streamsLength = streams.length;
        for (uint256 i = 1; i < streamsLength; i++) {
            if (streams[i].status == StreamStatus.ACTIVE)
                _moveRewardsToPending(account, i);
        }
    }

    /// @dev moves a set of stream Id rewards to pending.
    /// `_before` must be called before to update the streams rps.
    /// @param account the user account address.
    /// @param streamIds to claim.
    function _batchClaimRewards(address account, uint256[] calldata streamIds)
        internal
        virtual
    {
        for (uint256 i = 0; i < streamIds.length; i++) {
            if (streams[streamIds[i]].status == StreamStatus.ACTIVE)
                _moveRewardsToPending(account, streamIds[i]);
        }
    }

    /// @dev calculate the shares for a user per AURORA stream and other streams
    /// @param amount the staked amount
    /// WARNING: rewards are not claimed during stake.
    /// The UI must make sure to claim rewards before adding more stake.
    /// Unclaimed rewards will be lost.
    /// `_before()` must be called before `_stake` to update streams rps
    /// compounded AURORA rewards.
    function _stake(address account, uint256 amount) internal virtual {
        // recalculation of shares for user
        User storage userAccount = users[account];
        uint256 _amountOfShares = 0;
        if (totalAuroraShares == 0) {
            // initialize the number of shares (_amountOfShares) owning 100% of the stake (amount)
            _amountOfShares = amount;
        } else {
            uint256 numerator = amount * totalAuroraShares;
            _amountOfShares = numerator / totalAmountOfStakedAurora;
            // check that rounding is needed (result * denominator < numerator).
            if (_amountOfShares * totalAmountOfStakedAurora < numerator) {
                // Round up so users don't get less sharesValue than their staked amount
                _amountOfShares += 1;
            }
        }
        userAccount.auroraShares += _amountOfShares;
        totalAuroraShares += _amountOfShares;
        totalAmountOfStakedAurora += amount;
        userAccount.deposit += amount;

        // Calculate stream shares
        uint256 weightedAmountOfSharesPerStream = _weightedShares(
            _amountOfShares,
            block.timestamp
        );
        totalStreamShares += weightedAmountOfSharesPerStream;
        userAccount.streamShares += weightedAmountOfSharesPerStream;
        uint256 streamsLength = streams.length;
        for (uint256 i = 1; i < streamsLength; i++) {
            userAccount.rpsDuringLastClaim[i] = streams[i].rps; // The new shares should not claim old rewards
        }
        emit Staked(account, amount, _amountOfShares);
    }

    /// WARNING: rewards are not claimed during unstake.
    /// The UI must make sure to claim rewards before unstaking.
    /// Unclaimed rewards will be lost.
    /// `_before()` must be called before `_unstake` to update streams rps
    function _unstake(uint256 amount, uint256 stakeValue) internal virtual {
        require(amount != 0, "E39"); // ZERO_AMOUNT
        require(amount <= stakeValue, "E40"); // NOT_ENOUGH_STAKE_BALANCE
        User storage userAccount = users[msg.sender];
        // move rewards to pending
        // remove the shares from everywhere
        totalAuroraShares -= userAccount.auroraShares;
        totalStreamShares -= userAccount.streamShares;
        userAccount.auroraShares = 0;
        userAccount.streamShares = 0;
        // update the total Aurora staked and deposits
        totalAmountOfStakedAurora -= stakeValue;
        userAccount.deposit = 0;
        // move unstaked AURORA to pending.
        userAccount.pendings[0] += amount;
        userAccount.releaseTime[0] = block.timestamp + streams[0].tau;
        emit Pending(0, msg.sender, userAccount.pendings[0]);
        emit Unstaked(msg.sender, amount);
        // restake the rest
        uint256 amountToRestake = stakeValue - amount;
        if (amountToRestake > 0) {
            _stake(msg.sender, amountToRestake);
        }
    }

    /// @dev validates the stream parameters prior proposing it.
    /// @param streamOwner stream owner address
    /// @param rewardToken stream reward token address
    /// @param maxDepositAmount the max reward token deposit
    /// @param minDepositAmount the min reward token deposit
    /// @param scheduleTimes the stream schedule time list
    /// @param scheduleRewards the stream schedule reward list
    /// @param tau the tau is (pending release period) for this stream (e.g one day)
    function _validateStreamParameters(
        address streamOwner,
        address rewardToken,
        uint256 maxDepositAmount,
        uint256 minDepositAmount,
        uint256[] memory scheduleTimes,
        uint256[] memory scheduleRewards,
        uint256 tau
    ) internal view virtual {
        require(streamOwner != address(0) && rewardToken != address(0), "E4"); // INVALID_ADDRESS
        require(maxDepositAmount > 0, "E51"); // ZERO_MAX_DEPOSIT
        require(minDepositAmount > 0, "E52"); // ZERO_MIN_DEPOSIT
        require(minDepositAmount <= maxDepositAmount, "E43"); // INVALID_MIN_DEPOSIT
        require(tau != 0, "E44"); // INVALID_TAU_PERIOD
        _validateStreamSchedule(
            maxDepositAmount,
            scheduleTimes,
            scheduleRewards
        );
    }

    /// @dev validate stream schedule parameters.abi
    /// @param maxDepositAmount the max reward token deposit
    /// @param scheduleTimes the stream schedule time list
    /// @param scheduleRewards the stream schedule reward list
    function _validateStreamSchedule(
        uint256 maxDepositAmount,
        uint256[] memory scheduleTimes,
        uint256[] memory scheduleRewards
    ) internal view virtual {
        require(
            maxDepositAmount == scheduleRewards[0] &&
                scheduleTimes[0] > block.timestamp &&
                scheduleTimes.length == scheduleRewards.length &&
                scheduleTimes.length >= 2,
            "E45" // INVALID_SCHEDULE_PARAMS
        );
        for (uint256 i = 1; i < scheduleTimes.length; i++) {
            require(
                scheduleTimes[i] > scheduleTimes[i - 1] &&
                    scheduleRewards[i] <= scheduleRewards[i - 1],
                "E48" // INVALID_SCHEDULE_PARAMS
            );
        }
        require(scheduleRewards[scheduleRewards.length - 1] == 0, "E50"); // INVALID_SCHEDULE_PARAMS
    }

    /// @dev updates the stream reward schedule if the reward token amount is less than
    /// the max deposit amount.
    /// @param streamId the stream index
    /// @param rewardTokenAmount the stream reward token amount
    function _updateStreamRewardSchedules(
        uint256 streamId,
        uint256 rewardTokenAmount
    ) internal virtual {
        uint256 streamScheduleRewardLength = streams[streamId]
            .schedule
            .reward
            .length;
        for (uint256 i = 0; i < streamScheduleRewardLength; i++) {
            streams[streamId].schedule.reward[i] =
                (streams[streamId].schedule.reward[i] * rewardTokenAmount) /
                streams[streamId].maxDepositAmount;
        }
    }

    /// @dev withdraw stream rewards after the release time.
    /// @param streamId the stream index
    function _withdraw(uint256 streamId) internal virtual {
        User storage userAccount = users[msg.sender];
        uint256 pendingAmount = userAccount.pendings[streamId];
        userAccount.pendings[streamId] = 0;
        emit Released(streamId, msg.sender, pendingAmount);
        ITreasury(treasury).payRewards(
            msg.sender,
            streams[streamId].rewardToken,
            pendingAmount
        );
    }
}
