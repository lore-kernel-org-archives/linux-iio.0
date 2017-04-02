Return-Path: <SRS0=tmZH=3K=intel.com=fengguang.wu@kernel.org>
Date: Sun, 2 Apr 2017 13:23:07 +0800
From: kbuild test robot <lkp@intel.com>
To: simran singhal <singhalsimran0@gmail.com>
Cc: kbuild-all@01.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: health: afe440x: Remove code in comments
Message-ID: <201704021322.2vMNb4ET%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490978804-25549-2-git-send-email-singhalsimran0@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi simran,

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.11-rc4 next-20170331]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/simran-singhal/iio-health-Clean-up/20170402-095718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
   drivers/iio/health/afe440x.h:98:1: sparse: Expected ; at end of declaration
   drivers/iio/health/afe440x.h:98:1: sparse: got struct
   drivers/iio/health/afe440x.h:103:1: sparse: Expected ; at the end of type declaration
   drivers/iio/health/afe440x.h:103:1: sparse: got }
   drivers/iio/health/afe440x.h:96:8: sparse: undefined identifier '_name_show'
   drivers/iio/health/afe4403.c:110:9: sparse: undefined identifier 'AFE440X_INTENSITY_CHAN'
>> drivers/iio/health/afe4403.c:110:31: sparse: not a function <noident>
   drivers/iio/health/afe4403.c:111:9: sparse: undefined identifier 'AFE440X_INTENSITY_CHAN'
   drivers/iio/health/afe4403.c:112:9: sparse: undefined identifier 'AFE440X_INTENSITY_CHAN'
   drivers/iio/health/afe4403.c:113:9: sparse: undefined identifier 'AFE440X_INTENSITY_CHAN'
   drivers/iio/health/afe4403.c:114:9: sparse: undefined identifier 'AFE440X_INTENSITY_CHAN'
   drivers/iio/health/afe4403.c:115:9: sparse: undefined identifier 'AFE440X_INTENSITY_CHAN'
   drivers/iio/health/afe4403.c:115:31: sparse: not a function <noident>
   drivers/iio/health/afe4403.c:117:9: sparse: undefined identifier 'AFE440X_CURRENT_CHAN'
   drivers/iio/health/afe4403.c:118:9: sparse: undefined identifier 'AFE440X_CURRENT_CHAN'
   drivers/iio/health/afe4403.c:145:45: sparse: undefined identifier 'to_afe440x_attr'
   drivers/iio/health/afe4403.c:150:57: sparse: using member 'field' in incomplete struct afe440x_attr
   drivers/iio/health/afe4403.c:154:36: sparse: using member 'table_size' in incomplete struct afe440x_attr
   drivers/iio/health/afe4403.c:157:31: sparse: using member 'val_table' in incomplete struct afe440x_attr
   drivers/iio/health/afe4403.c:158:31: sparse: using member 'val_table' in incomplete struct afe440x_attr
   drivers/iio/health/afe4403.c:169:45: sparse: undefined identifier 'to_afe440x_attr'
   drivers/iio/health/afe4403.c:176:41: sparse: using member 'table_size' in incomplete struct afe440x_attr
   drivers/iio/health/afe4403.c:177:33: sparse: using member 'val_table' in incomplete struct afe440x_attr
   drivers/iio/health/afe4403.c:180:32: sparse: using member 'table_size' in incomplete struct afe440x_attr
   drivers/iio/health/afe4403.c:183:15: sparse: using member 'field' in incomplete struct afe440x_attr
   drivers/iio/health/afe4403.c:203:10: sparse: undefined identifier 'dev_attr_in_intensity_resistance_available'
   drivers/iio/health/afe4403.c:204:10: sparse: undefined identifier 'dev_attr_in_intensity_capacitance_available'
   drivers/iio/health/afe4403.c:205:10: sparse: undefined identifier 'afe440x_attr_in_intensity1_resistance'
   drivers/iio/health/afe4403.c:206:10: sparse: undefined identifier 'afe440x_attr_in_intensity1_capacitance'
   drivers/iio/health/afe4403.c:207:10: sparse: undefined identifier 'afe440x_attr_in_intensity2_resistance'
   drivers/iio/health/afe4403.c:208:10: sparse: undefined identifier 'afe440x_attr_in_intensity2_capacitance'
   drivers/iio/health/afe4403.c:209:10: sparse: undefined identifier 'afe440x_attr_in_intensity3_resistance'
   drivers/iio/health/afe4403.c:210:10: sparse: undefined identifier 'afe440x_attr_in_intensity3_capacitance'
   drivers/iio/health/afe4403.c:211:10: sparse: undefined identifier 'afe440x_attr_in_intensity4_resistance'
   drivers/iio/health/afe4403.c:212:10: sparse: undefined identifier 'afe440x_attr_in_intensity4_capacitance'
   In file included from include/linux/kobject.h:21:0,
                    from include/linux/device.h:17,
                    from drivers/iio/health/afe4403.c:17:
   drivers/iio/health/afe440x.h:96:23: error: '_name_show' undeclared here (not in a function)
    static DEVICE_ATTR_RO(_name)
                          ^
   include/linux/sysfs.h:116:10: note: in definition of macro '__ATTR_RO'
     .show = _name##_show,      \
             ^~~~~
   drivers/iio/health/afe440x.h:96:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    static DEVICE_ATTR_RO(_name)
           ^~~~~~~~~~~~~~
   In file included from drivers/iio/health/afe4403.c:34:0:
   drivers/iio/health/afe440x.h:98:1: error: expected ',' or ';' before 'struct'
    struct afe440x_attr {
    ^~~~~~
   drivers/iio/health/afe4403.c:110:2: error: implicit declaration of function 'AFE440X_INTENSITY_CHAN' [-Werror=implicit-function-declaration]
     AFE440X_INTENSITY_CHAN(LED2, 0),
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4403.c:110:2: error: initializer element is not constant
   drivers/iio/health/afe4403.c:110:2: note: (near initialization for 'afe4403_channels[0].type')
   drivers/iio/health/afe4403.c:111:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(ALED2, 0),
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4403.c:111:2: note: (near initialization for 'afe4403_channels[0].channel')
   drivers/iio/health/afe4403.c:112:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(LED1, 0),
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4403.c:112:2: note: (near initialization for 'afe4403_channels[0].channel2')
   drivers/iio/health/afe4403.c:113:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(ALED1, 0),
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4403.c:113:2: note: (near initialization for 'afe4403_channels[0].address')
   drivers/iio/health/afe4403.c:114:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(LED2_ALED2, 0),
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4403.c:114:2: note: (near initialization for 'afe4403_channels[0].scan_index')
   drivers/iio/health/afe4403.c:115:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(LED1_ALED1, 0),
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4403.c:115:2: note: (near initialization for 'afe4403_channels[0].scan_type.sign')
   drivers/iio/health/afe4403.c:117:2: error: implicit declaration of function 'AFE440X_CURRENT_CHAN' [-Werror=implicit-function-declaration]
     AFE440X_CURRENT_CHAN(LED2),
     ^~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4403.c:117:2: error: initializer element is not constant
   drivers/iio/health/afe4403.c:117:2: note: (near initialization for 'afe4403_channels[0].scan_type.realbits')
   drivers/iio/health/afe4403.c:118:2: error: initializer element is not constant
     AFE440X_CURRENT_CHAN(LED1),
     ^~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4403.c:118:2: note: (near initialization for 'afe4403_channels[0].scan_type.storagebits')
   drivers/iio/health/afe4403.c:125:1: warning: data definition has no type or storage class
    AFE440X_TABLE_ATTR(in_intensity_resistance_available, afe4403_res_table);
    ^~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4403.c:125:1: error: type defaults to 'int' in declaration of 'AFE440X_TABLE_ATTR' [-Werror=implicit-int]
   drivers/iio/health/afe4403.c:125:1: warning: parameter names (without types) in function declaration
   drivers/iio/health/afe4403.c:137:1: warning: data definition has no type or storage class
    AFE440X_TABLE_ATTR(in_intensity_capacitance_available, afe4403_cap_table);
    ^~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4403.c:137:1: error: type defaults to 'int' in declaration of 'AFE440X_TABLE_ATTR' [-Werror=implicit-int]
   drivers/iio/health/afe4403.c:137:1: warning: parameter names (without types) in function declaration
   drivers/iio/health/afe4403.c: In function 'afe440x_show_register':
   drivers/iio/health/afe4403.c:145:38: error: implicit declaration of function 'to_afe440x_attr' [-Werror=implicit-function-declaration]
     struct afe440x_attr *afe440x_attr = to_afe440x_attr(attr);
                                         ^~~~~~~~~~~~~~~
   drivers/iio/health/afe4403.c:145:38: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   drivers/iio/health/afe4403.c:150:50: error: dereferencing pointer to incomplete type 'struct afe440x_attr'
     ret = regmap_field_read(afe->fields[afe440x_attr->field], &reg_val);
                                                     ^~
   drivers/iio/health/afe4403.c:150:50: error: request for member 'field' in something not a structure or union
   drivers/iio/health/afe4403.c:150:37: error: array subscript is not an integer
     ret = regmap_field_read(afe->fields[afe440x_attr->field], &reg_val);
                                        ^
--
   include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
   drivers/iio/health/afe440x.h:98:1: sparse: Expected ; at end of declaration
   drivers/iio/health/afe440x.h:98:1: sparse: got struct
   drivers/iio/health/afe440x.h:103:1: sparse: Expected ; at the end of type declaration
   drivers/iio/health/afe440x.h:103:1: sparse: got }
   drivers/iio/health/afe440x.h:96:8: sparse: undefined identifier '_name_show'
   drivers/iio/health/afe4404.c:137:9: sparse: undefined identifier 'AFE440X_INTENSITY_CHAN'
>> drivers/iio/health/afe4404.c:137:31: sparse: not a function <noident>
   drivers/iio/health/afe4404.c:138:9: sparse: undefined identifier 'AFE440X_INTENSITY_CHAN'
   drivers/iio/health/afe4404.c:139:9: sparse: undefined identifier 'AFE440X_INTENSITY_CHAN'
   drivers/iio/health/afe4404.c:140:9: sparse: undefined identifier 'AFE440X_INTENSITY_CHAN'
   drivers/iio/health/afe4404.c:141:9: sparse: undefined identifier 'AFE440X_INTENSITY_CHAN'
   drivers/iio/health/afe4404.c:142:9: sparse: undefined identifier 'AFE440X_INTENSITY_CHAN'
   drivers/iio/health/afe4404.c:142:31: sparse: not a function <noident>
   drivers/iio/health/afe4404.c:144:9: sparse: undefined identifier 'AFE440X_CURRENT_CHAN'
   drivers/iio/health/afe4404.c:145:9: sparse: undefined identifier 'AFE440X_CURRENT_CHAN'
   drivers/iio/health/afe4404.c:146:9: sparse: undefined identifier 'AFE440X_CURRENT_CHAN'
   drivers/iio/health/afe4404.c:179:45: sparse: undefined identifier 'to_afe440x_attr'
   drivers/iio/health/afe4404.c:184:57: sparse: using member 'field' in incomplete struct afe440x_attr
   drivers/iio/health/afe4404.c:188:36: sparse: using member 'table_size' in incomplete struct afe440x_attr
   drivers/iio/health/afe4404.c:191:31: sparse: using member 'val_table' in incomplete struct afe440x_attr
   drivers/iio/health/afe4404.c:192:31: sparse: using member 'val_table' in incomplete struct afe440x_attr
   drivers/iio/health/afe4404.c:203:45: sparse: undefined identifier 'to_afe440x_attr'
   drivers/iio/health/afe4404.c:210:41: sparse: using member 'table_size' in incomplete struct afe440x_attr
   drivers/iio/health/afe4404.c:211:33: sparse: using member 'val_table' in incomplete struct afe440x_attr
   drivers/iio/health/afe4404.c:214:32: sparse: using member 'table_size' in incomplete struct afe440x_attr
   drivers/iio/health/afe4404.c:217:15: sparse: using member 'field' in incomplete struct afe440x_attr
   drivers/iio/health/afe4404.c:237:10: sparse: undefined identifier 'dev_attr_in_intensity_resistance_available'
   drivers/iio/health/afe4404.c:238:10: sparse: undefined identifier 'dev_attr_in_intensity_capacitance_available'
   drivers/iio/health/afe4404.c:239:10: sparse: undefined identifier 'afe440x_attr_in_intensity1_resistance'
   drivers/iio/health/afe4404.c:240:10: sparse: undefined identifier 'afe440x_attr_in_intensity1_capacitance'
   drivers/iio/health/afe4404.c:241:10: sparse: undefined identifier 'afe440x_attr_in_intensity2_resistance'
   drivers/iio/health/afe4404.c:242:10: sparse: undefined identifier 'afe440x_attr_in_intensity2_capacitance'
   drivers/iio/health/afe4404.c:243:10: sparse: undefined identifier 'afe440x_attr_in_intensity3_resistance'
   drivers/iio/health/afe4404.c:244:10: sparse: undefined identifier 'afe440x_attr_in_intensity3_capacitance'
   drivers/iio/health/afe4404.c:245:10: sparse: undefined identifier 'afe440x_attr_in_intensity4_resistance'
   drivers/iio/health/afe4404.c:246:10: sparse: undefined identifier 'afe440x_attr_in_intensity4_capacitance'
   In file included from include/linux/kobject.h:21:0,
                    from include/linux/device.h:17,
                    from drivers/iio/health/afe4404.c:17:
   drivers/iio/health/afe440x.h:96:23: error: '_name_show' undeclared here (not in a function)
    static DEVICE_ATTR_RO(_name)
                          ^
   include/linux/sysfs.h:116:10: note: in definition of macro '__ATTR_RO'
     .show = _name##_show,      \
             ^~~~~
   drivers/iio/health/afe440x.h:96:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    static DEVICE_ATTR_RO(_name)
           ^~~~~~~~~~~~~~
   In file included from drivers/iio/health/afe4404.c:34:0:
   drivers/iio/health/afe440x.h:98:1: error: expected ',' or ';' before 'struct'
    struct afe440x_attr {
    ^~~~~~
   drivers/iio/health/afe4404.c:137:2: error: implicit declaration of function 'AFE440X_INTENSITY_CHAN' [-Werror=implicit-function-declaration]
     AFE440X_INTENSITY_CHAN(LED2, BIT(IIO_CHAN_INFO_OFFSET)),
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4404.c:137:2: error: initializer element is not constant
   drivers/iio/health/afe4404.c:137:2: note: (near initialization for 'afe4404_channels[0].type')
   drivers/iio/health/afe4404.c:138:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(ALED2, BIT(IIO_CHAN_INFO_OFFSET)),
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4404.c:138:2: note: (near initialization for 'afe4404_channels[0].channel')
   drivers/iio/health/afe4404.c:139:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(LED1, BIT(IIO_CHAN_INFO_OFFSET)),
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4404.c:139:2: note: (near initialization for 'afe4404_channels[0].channel2')
   drivers/iio/health/afe4404.c:140:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(ALED1, BIT(IIO_CHAN_INFO_OFFSET)),
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4404.c:140:2: note: (near initialization for 'afe4404_channels[0].address')
   drivers/iio/health/afe4404.c:141:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(LED2_ALED2, 0),
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4404.c:141:2: note: (near initialization for 'afe4404_channels[0].scan_index')
   drivers/iio/health/afe4404.c:142:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(LED1_ALED1, 0),
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4404.c:142:2: note: (near initialization for 'afe4404_channels[0].scan_type.sign')
   drivers/iio/health/afe4404.c:144:2: error: implicit declaration of function 'AFE440X_CURRENT_CHAN' [-Werror=implicit-function-declaration]
     AFE440X_CURRENT_CHAN(LED2),
     ^~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4404.c:144:2: error: initializer element is not constant
   drivers/iio/health/afe4404.c:144:2: note: (near initialization for 'afe4404_channels[0].scan_type.realbits')
   drivers/iio/health/afe4404.c:145:2: error: initializer element is not constant
     AFE440X_CURRENT_CHAN(ALED2),
     ^~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4404.c:145:2: note: (near initialization for 'afe4404_channels[0].scan_type.storagebits')
   drivers/iio/health/afe4404.c:146:2: error: initializer element is not constant
     AFE440X_CURRENT_CHAN(LED1),
     ^~~~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4404.c:146:2: note: (near initialization for 'afe4404_channels[0].scan_type.shift')
   drivers/iio/health/afe4404.c:159:1: warning: data definition has no type or storage class
    AFE440X_TABLE_ATTR(in_intensity_resistance_available, afe4404_res_table);
    ^~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4404.c:159:1: error: type defaults to 'int' in declaration of 'AFE440X_TABLE_ATTR' [-Werror=implicit-int]
   drivers/iio/health/afe4404.c:159:1: warning: parameter names (without types) in function declaration
   drivers/iio/health/afe4404.c:171:1: warning: data definition has no type or storage class
    AFE440X_TABLE_ATTR(in_intensity_capacitance_available, afe4404_cap_table);
    ^~~~~~~~~~~~~~~~~~
   drivers/iio/health/afe4404.c:171:1: error: type defaults to 'int' in declaration of 'AFE440X_TABLE_ATTR' [-Werror=implicit-int]
   drivers/iio/health/afe4404.c:171:1: warning: parameter names (without types) in function declaration
   drivers/iio/health/afe4404.c: In function 'afe440x_show_register':
   drivers/iio/health/afe4404.c:179:38: error: implicit declaration of function 'to_afe440x_attr' [-Werror=implicit-function-declaration]
     struct afe440x_attr *afe440x_attr = to_afe440x_attr(attr);
                                         ^~~~~~~~~~~~~~~
   drivers/iio/health/afe4404.c:179:38: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   drivers/iio/health/afe4404.c:184:50: error: dereferencing pointer to incomplete type 'struct afe440x_attr'
     ret = regmap_field_read(afe->fields[afe440x_attr->field], &reg_val);

vim +110 drivers/iio/health/afe4403.c

b36e8257 Andrew F. Davis 2016-05-01   94  static const unsigned int afe4403_channel_values[] = {
b36e8257 Andrew F. Davis 2016-05-01   95  	[LED2] = AFE440X_LED2VAL,
b36e8257 Andrew F. Davis 2016-05-01   96  	[ALED2] = AFE440X_ALED2VAL,
b36e8257 Andrew F. Davis 2016-05-01   97  	[LED1] = AFE440X_LED1VAL,
b36e8257 Andrew F. Davis 2016-05-01   98  	[ALED1] = AFE440X_ALED1VAL,
b36e8257 Andrew F. Davis 2016-05-01   99  	[LED2_ALED2] = AFE440X_LED2_ALED2VAL,
b36e8257 Andrew F. Davis 2016-05-01  100  	[LED1_ALED1] = AFE440X_LED1_ALED1VAL,
b36e8257 Andrew F. Davis 2016-05-01  101  };
b36e8257 Andrew F. Davis 2016-05-01  102  
b36e8257 Andrew F. Davis 2016-05-01  103  static const unsigned int afe4403_channel_leds[] = {
3ff34ee2 Andrew F. Davis 2016-05-01  104  	[LED2] = F_ILED2,
3ff34ee2 Andrew F. Davis 2016-05-01  105  	[LED1] = F_ILED1,
eec96d1e Andrew F. Davis 2016-02-06  106  };
eec96d1e Andrew F. Davis 2016-02-06  107  
eec96d1e Andrew F. Davis 2016-02-06  108  static const struct iio_chan_spec afe4403_channels[] = {
eec96d1e Andrew F. Davis 2016-02-06  109  	/* ADC values */
24b9dea7 Andrew F. Davis 2016-05-01 @110  	AFE440X_INTENSITY_CHAN(LED2, 0),
24b9dea7 Andrew F. Davis 2016-05-01  111  	AFE440X_INTENSITY_CHAN(ALED2, 0),
24b9dea7 Andrew F. Davis 2016-05-01  112  	AFE440X_INTENSITY_CHAN(LED1, 0),
24b9dea7 Andrew F. Davis 2016-05-01  113  	AFE440X_INTENSITY_CHAN(ALED1, 0),
24b9dea7 Andrew F. Davis 2016-05-01  114  	AFE440X_INTENSITY_CHAN(LED2_ALED2, 0),
24b9dea7 Andrew F. Davis 2016-05-01  115  	AFE440X_INTENSITY_CHAN(LED1_ALED1, 0),
eec96d1e Andrew F. Davis 2016-02-06  116  	/* LED current */
3ff34ee2 Andrew F. Davis 2016-05-01  117  	AFE440X_CURRENT_CHAN(LED2),
3ff34ee2 Andrew F. Davis 2016-05-01  118  	AFE440X_CURRENT_CHAN(LED1),

:::::: The code at line 110 was first introduced by commit
:::::: 24b9dea764bdf0de8434fb4567e7f62038ba869e iio: health/afe440x: Remove channel names

:::::: TO: Andrew F. Davis <afd@ti.com>
:::::: CC: Jonathan Cameron <jic23@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
