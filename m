Return-Path: <SRS0=tmZH=3K=intel.com=fengguang.wu@kernel.org>
Date: Sun, 2 Apr 2017 11:25:48 +0800
From: kbuild test robot <lkp@intel.com>
To: simran singhal <singhalsimran0@gmail.com>
Cc: kbuild-all@01.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: health: afe440x: Remove code in comments
Message-ID: <201704021117.KGFNCqeb%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
In-Reply-To: <1490978804-25549-2-git-send-email-singhalsimran0@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi simran,

[auto build test ERROR on iio/togreg]
[also build test ERROR on v4.11-rc4 next-20170331]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/simran-singhal/iio-health-Clean-up/20170402-095718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21:0,
                    from include/linux/device.h:17,
                    from drivers/iio/health/afe4403.c:17:
   drivers/iio/health/afe440x.h:96:23: error: '_name_show' undeclared here (not in a function)
    static DEVICE_ATTR_RO(_name)
                          ^
   include/linux/sysfs.h:116:10: note: in definition of macro '__ATTR_RO'
     .show = _name##_show,      \
             ^
   drivers/iio/health/afe440x.h:96:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    static DEVICE_ATTR_RO(_name)
           ^
   In file included from drivers/iio/health/afe4403.c:34:0:
   drivers/iio/health/afe440x.h:98:1: error: expected ',' or ';' before 'struct'
    struct afe440x_attr {
    ^
   drivers/iio/health/afe4403.c:110:2: error: implicit declaration of function 'AFE440X_INTENSITY_CHAN' [-Werror=implicit-function-declaration]
     AFE440X_INTENSITY_CHAN(LED2, 0),
     ^
>> drivers/iio/health/afe4403.c:110:2: warning: missing braces around initializer [-Wmissing-braces]
   drivers/iio/health/afe4403.c:110:2: warning: (near initialization for 'afe4403_channels[0]') [-Wmissing-braces]
   drivers/iio/health/afe4403.c:110:2: error: initializer element is not constant
   drivers/iio/health/afe4403.c:110:2: error: (near initialization for 'afe4403_channels[0].type')
   drivers/iio/health/afe4403.c:111:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(ALED2, 0),
     ^
   drivers/iio/health/afe4403.c:111:2: error: (near initialization for 'afe4403_channels[0].channel')
   drivers/iio/health/afe4403.c:112:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(LED1, 0),
     ^
   drivers/iio/health/afe4403.c:112:2: error: (near initialization for 'afe4403_channels[0].channel2')
   drivers/iio/health/afe4403.c:113:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(ALED1, 0),
     ^
   drivers/iio/health/afe4403.c:113:2: error: (near initialization for 'afe4403_channels[0].address')
   drivers/iio/health/afe4403.c:114:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(LED2_ALED2, 0),
     ^
   drivers/iio/health/afe4403.c:114:2: error: (near initialization for 'afe4403_channels[0].scan_index')
   drivers/iio/health/afe4403.c:115:2: error: initializer element is not constant
     AFE440X_INTENSITY_CHAN(LED1_ALED1, 0),
     ^
   drivers/iio/health/afe4403.c:115:2: error: (near initialization for 'afe4403_channels[0].scan_type.sign')
   drivers/iio/health/afe4403.c:117:2: error: implicit declaration of function 'AFE440X_CURRENT_CHAN' [-Werror=implicit-function-declaration]
     AFE440X_CURRENT_CHAN(LED2),
     ^
   drivers/iio/health/afe4403.c:117:2: error: initializer element is not constant
   drivers/iio/health/afe4403.c:117:2: error: (near initialization for 'afe4403_channels[0].scan_type.realbits')
   drivers/iio/health/afe4403.c:118:2: error: initializer element is not constant
     AFE440X_CURRENT_CHAN(LED1),
     ^
   drivers/iio/health/afe4403.c:118:2: error: (near initialization for 'afe4403_channels[0].scan_type.storagebits')
   drivers/iio/health/afe4403.c:125:1: warning: data definition has no type or storage class
    AFE440X_TABLE_ATTR(in_intensity_resistance_available, afe4403_res_table);
    ^
   drivers/iio/health/afe4403.c:125:1: error: type defaults to 'int' in declaration of 'AFE440X_TABLE_ATTR' [-Werror=implicit-int]
   drivers/iio/health/afe4403.c:125:1: warning: parameter names (without types) in function declaration
   drivers/iio/health/afe4403.c:137:1: warning: data definition has no type or storage class
    AFE440X_TABLE_ATTR(in_intensity_capacitance_available, afe4403_cap_table);
    ^
   drivers/iio/health/afe4403.c:137:1: error: type defaults to 'int' in declaration of 'AFE440X_TABLE_ATTR' [-Werror=implicit-int]
   drivers/iio/health/afe4403.c:137:1: warning: parameter names (without types) in function declaration
   drivers/iio/health/afe4403.c: In function 'afe440x_show_register':
   drivers/iio/health/afe4403.c:145:9: error: implicit declaration of function 'to_afe440x_attr' [-Werror=implicit-function-declaration]
     struct afe440x_attr *afe440x_attr = to_afe440x_attr(attr);
            ^
   drivers/iio/health/afe4403.c:145:38: warning: initialization makes pointer from integer without a cast
     struct afe440x_attr *afe440x_attr = to_afe440x_attr(attr);
                                         ^
   drivers/iio/health/afe4403.c:150:50: error: dereferencing pointer to incomplete type
     ret = regmap_field_read(afe->fields[afe440x_attr->field], &reg_val);
                                                     ^
   drivers/iio/health/afe4403.c:150:50: error: request for member 'field' in something not a structure or union
   drivers/iio/health/afe4403.c:150:37: error: array subscript is not an integer
     ret = regmap_field_read(afe->fields[afe440x_attr->field], &reg_val);
                                        ^
   drivers/iio/health/afe4403.c:150:8: warning: passing argument 1 of 'regmap_field_read' from incompatible pointer type
     ret = regmap_field_read(afe->fields[afe440x_attr->field], &reg_val);
           ^
   In file included from drivers/iio/health/afe4403.c:22:0:
   include/linux/regmap.h:850:5: note: expected 'struct regmap_field *' but argument is of type 'const struct iio_chan_spec *'
    int regmap_field_read(struct regmap_field *field, unsigned int *val);
        ^
   drivers/iio/health/afe4403.c:154:29: error: dereferencing pointer to incomplete type
     if (reg_val >= afe440x_attr->table_size)
                                ^
   drivers/iio/health/afe4403.c:154:29: error: request for member 'table_size' in something not a structure or union
   drivers/iio/health/afe4403.c:154:14: warning: comparison between pointer and integer
     if (reg_val >= afe440x_attr->table_size)
                 ^
   drivers/iio/health/afe4403.c:157:24: error: dereferencing pointer to incomplete type
     vals[0] = afe440x_attr->val_table[reg_val].integer;
                           ^
   drivers/iio/health/afe4403.c:157:24: error: request for member 'val_table' in something not a structure or union
   drivers/iio/health/afe4403.c:157:44: error: 'const struct iio_chan_spec' has no member named 'integer'
     vals[0] = afe440x_attr->val_table[reg_val].integer;
                                               ^
   drivers/iio/health/afe4403.c:157:10: warning: assignment makes integer from pointer without a cast
     vals[0] = afe440x_attr->val_table[reg_val].integer;
             ^
   drivers/iio/health/afe4403.c:158:24: error: dereferencing pointer to incomplete type
     vals[1] = afe440x_attr->val_table[reg_val].fract;
                           ^
   drivers/iio/health/afe4403.c:158:24: error: request for member 'val_table' in something not a structure or union
   drivers/iio/health/afe4403.c:158:44: error: 'const struct iio_chan_spec' has no member named 'fract'
     vals[1] = afe440x_attr->val_table[reg_val].fract;
                                               ^
   drivers/iio/health/afe4403.c:158:10: warning: assignment makes integer from pointer without a cast
     vals[1] = afe440x_attr->val_table[reg_val].fract;
             ^
   drivers/iio/health/afe4403.c: In function 'afe440x_store_register':
   drivers/iio/health/afe4403.c:169:38: warning: initialization makes pointer from integer without a cast
     struct afe440x_attr *afe440x_attr = to_afe440x_attr(attr);
                                         ^
   drivers/iio/health/afe4403.c:176:34: error: dereferencing pointer to incomplete type
     for (val = 0; val < afe440x_attr->table_size; val++)
                                     ^
   drivers/iio/health/afe4403.c:176:34: error: request for member 'table_size' in something not a structure or union
   drivers/iio/health/afe4403.c:176:20: warning: comparison between pointer and integer
     for (val = 0; val < afe440x_attr->table_size; val++)
--
   drivers/iio/health/afe4403.c:177:44: warning: comparison between pointer and integer
      if (afe440x_attr->val_table[val].integer == integer &&
                                               ^
   drivers/iio/health/afe4403.c:178:19: error: dereferencing pointer to incomplete type
          afe440x_attr->val_table[val].fract == fract)
                      ^
   drivers/iio/health/afe4403.c:178:19: error: request for member 'val_table' in something not a structure or union
   drivers/iio/health/afe4403.c:178:35: error: 'const struct iio_chan_spec' has no member named 'fract'
          afe440x_attr->val_table[val].fract == fract)
                                      ^
   drivers/iio/health/afe4403.c:178:42: warning: comparison between pointer and integer
          afe440x_attr->val_table[val].fract == fract)
                                             ^
   drivers/iio/health/afe4403.c:180:25: error: dereferencing pointer to incomplete type
     if (val == afe440x_attr->table_size)
                            ^
   drivers/iio/health/afe4403.c:180:25: error: request for member 'table_size' in something not a structure or union
   drivers/iio/health/afe4403.c:180:10: warning: comparison between pointer and integer
     if (val == afe440x_attr->table_size)
             ^
   In file included from drivers/iio/health/afe4403.c:22:0:
   drivers/iio/health/afe4403.c:183:51: error: dereferencing pointer to incomplete type
     ret = regmap_field_write(afe->fields[afe440x_attr->field], val);
                                                      ^
   include/linux/regmap.h:85:32: note: in definition of macro 'regmap_field_write'
     regmap_field_update_bits_base(field, ~0, val, NULL, false, false)
                                   ^
   drivers/iio/health/afe4403.c:183:51: error: request for member 'field' in something not a structure or union
     ret = regmap_field_write(afe->fields[afe440x_attr->field], val);
                                                      ^
   include/linux/regmap.h:85:32: note: in definition of macro 'regmap_field_write'
     regmap_field_update_bits_base(field, ~0, val, NULL, false, false)
                                   ^
   drivers/iio/health/afe4403.c:183:38: error: array subscript is not an integer
     ret = regmap_field_write(afe->fields[afe440x_attr->field], val);
                                         ^
   include/linux/regmap.h:85:32: note: in definition of macro 'regmap_field_write'
     regmap_field_update_bits_base(field, ~0, val, NULL, false, false)
                                   ^
   include/linux/regmap.h:85:2: warning: passing argument 1 of 'regmap_field_update_bits_base' from incompatible pointer type
     regmap_field_update_bits_base(field, ~0, val, NULL, false, false)
     ^
   drivers/iio/health/afe4403.c:183:8: note: in expansion of macro 'regmap_field_write'
     ret = regmap_field_write(afe->fields[afe440x_attr->field], val);
           ^
   include/linux/regmap.h:851:5: note: expected 'struct regmap_field *' but argument is of type 'const struct iio_chan_spec *'
    int regmap_field_update_bits_base(struct regmap_field *field,
        ^
   drivers/iio/health/afe4403.c: At top level:
   drivers/iio/health/afe4403.c:190:8: error: type defaults to 'int' in declaration of 'AFE440X_ATTR' [-Werror=implicit-int]
    static AFE440X_ATTR(in_intensity1_resistance, F_RF_LED, afe4403_res_table);
           ^
   drivers/iio/health/afe4403.c:190:1: warning: parameter names (without types) in function declaration
    static AFE440X_ATTR(in_intensity1_resistance, F_RF_LED, afe4403_res_table);
    ^
   drivers/iio/health/afe4403.c:191:8: error: type defaults to 'int' in declaration of 'AFE440X_ATTR' [-Werror=implicit-int]
    static AFE440X_ATTR(in_intensity1_capacitance, F_CF_LED, afe4403_cap_table);
           ^
   drivers/iio/health/afe4403.c:191:1: warning: parameter names (without types) in function declaration
    static AFE440X_ATTR(in_intensity1_capacitance, F_CF_LED, afe4403_cap_table);
    ^
   drivers/iio/health/afe4403.c:193:8: error: type defaults to 'int' in declaration of 'AFE440X_ATTR' [-Werror=implicit-int]
    static AFE440X_ATTR(in_intensity2_resistance, F_RF_LED, afe4403_res_table);
           ^
   drivers/iio/health/afe4403.c:193:1: warning: parameter names (without types) in function declaration
    static AFE440X_ATTR(in_intensity2_resistance, F_RF_LED, afe4403_res_table);
    ^
   drivers/iio/health/afe4403.c:194:8: error: type defaults to 'int' in declaration of 'AFE440X_ATTR' [-Werror=implicit-int]
    static AFE440X_ATTR(in_intensity2_capacitance, F_CF_LED, afe4403_cap_table);
           ^
   drivers/iio/health/afe4403.c:194:1: warning: parameter names (without types) in function declaration
    static AFE440X_ATTR(in_intensity2_capacitance, F_CF_LED, afe4403_cap_table);
    ^
   drivers/iio/health/afe4403.c:196:8: error: type defaults to 'int' in declaration of 'AFE440X_ATTR' [-Werror=implicit-int]
    static AFE440X_ATTR(in_intensity3_resistance, F_RF_LED1, afe4403_res_table);
           ^
   drivers/iio/health/afe4403.c:196:1: warning: parameter names (without types) in function declaration
    static AFE440X_ATTR(in_intensity3_resistance, F_RF_LED1, afe4403_res_table);
    ^
   drivers/iio/health/afe4403.c:197:8: error: type defaults to 'int' in declaration of 'AFE440X_ATTR' [-Werror=implicit-int]
    static AFE440X_ATTR(in_intensity3_capacitance, F_CF_LED1, afe4403_cap_table);
           ^
   drivers/iio/health/afe4403.c:197:1: warning: parameter names (without types) in function declaration
    static AFE440X_ATTR(in_intensity3_capacitance, F_CF_LED1, afe4403_cap_table);
    ^
   drivers/iio/health/afe4403.c:199:8: error: type defaults to 'int' in declaration of 'AFE440X_ATTR' [-Werror=implicit-int]
    static AFE440X_ATTR(in_intensity4_resistance, F_RF_LED1, afe4403_res_table);
           ^
   drivers/iio/health/afe4403.c:199:1: warning: parameter names (without types) in function declaration
    static AFE440X_ATTR(in_intensity4_resistance, F_RF_LED1, afe4403_res_table);
    ^
   drivers/iio/health/afe4403.c:200:8: error: type defaults to 'int' in declaration of 'AFE440X_ATTR' [-Werror=implicit-int]
    static AFE440X_ATTR(in_intensity4_capacitance, F_CF_LED1, afe4403_cap_table);
           ^
   drivers/iio/health/afe4403.c:200:1: warning: parameter names (without types) in function declaration
    static AFE440X_ATTR(in_intensity4_capacitance, F_CF_LED1, afe4403_cap_table);
    ^
   drivers/iio/health/afe4403.c:203:3: error: 'dev_attr_in_intensity_resistance_available' undeclared here (not in a function)
     &dev_attr_in_intensity_resistance_available.attr,
      ^
>> drivers/iio/health/afe4403.c:203:45: error: request for member 'attr' in something not a structure or union
     &dev_attr_in_intensity_resistance_available.attr,
                                                ^
   drivers/iio/health/afe4403.c:203:2: error: initializer element is not constant
     &dev_attr_in_intensity_resistance_available.attr,
     ^
   drivers/iio/health/afe4403.c:203:2: error: (near initialization for 'afe440x_attributes[0]')
   drivers/iio/health/afe4403.c:204:3: error: 'dev_attr_in_intensity_capacitance_available' undeclared here (not in a function)
     &dev_attr_in_intensity_capacitance_available.attr,
      ^
   drivers/iio/health/afe4403.c:204:46: error: request for member 'attr' in something not a structure or union
     &dev_attr_in_intensity_capacitance_available.attr,
                                                 ^
   drivers/iio/health/afe4403.c:204:2: error: initializer element is not constant
     &dev_attr_in_intensity_capacitance_available.attr,
     ^
   drivers/iio/health/afe4403.c:204:2: error: (near initialization for 'afe440x_attributes[1]')
   drivers/iio/health/afe4403.c:205:3: error: 'afe440x_attr_in_intensity1_resistance' undeclared here (not in a function)
     &afe440x_attr_in_intensity1_resistance.dev_attr.attr,
      ^
>> drivers/iio/health/afe4403.c:205:40: error: request for member 'dev_attr' in something not a structure or union
     &afe440x_attr_in_intensity1_resistance.dev_attr.attr,
                                           ^
   drivers/iio/health/afe4403.c:205:49: error: request for member 'attr' in something not a structure or union
     &afe440x_attr_in_intensity1_resistance.dev_attr.attr,
                                                    ^
   drivers/iio/health/afe4403.c:205:2: error: initializer element is not constant
     &afe440x_attr_in_intensity1_resistance.dev_attr.attr,
     ^
   drivers/iio/health/afe4403.c:205:2: error: (near initialization for 'afe440x_attributes[2]')
   drivers/iio/health/afe4403.c:206:3: error: 'afe440x_attr_in_intensity1_capacitance' undeclared here (not in a function)
     &afe440x_attr_in_intensity1_capacitance.dev_attr.attr,
      ^
   drivers/iio/health/afe4403.c:206:41: error: request for member 'dev_attr' in something not a structure or union
     &afe440x_attr_in_intensity1_capacitance.dev_attr.attr,
                                            ^
   drivers/iio/health/afe4403.c:206:50: error: request for member 'attr' in something not a structure or union
     &afe440x_attr_in_intensity1_capacitance.dev_attr.attr,
                                                     ^
   drivers/iio/health/afe4403.c:206:2: error: initializer element is not constant
     &afe440x_attr_in_intensity1_capacitance.dev_attr.attr,
     ^
   drivers/iio/health/afe4403.c:206:2: error: (near initialization for 'afe440x_attributes[3]')
   drivers/iio/health/afe4403.c:207:3: error: 'afe440x_attr_in_intensity2_resistance' undeclared here (not in a function)
     &afe440x_attr_in_intensity2_resistance.dev_attr.attr,
      ^
   drivers/iio/health/afe4403.c:207:40: error: request for member 'dev_attr' in something not a structure or union
     &afe440x_attr_in_intensity2_resistance.dev_attr.attr,
                                           ^
   drivers/iio/health/afe4403.c:207:49: error: request for member 'attr' in something not a structure or union
     &afe440x_attr_in_intensity2_resistance.dev_attr.attr,
                                                    ^
   drivers/iio/health/afe4403.c:207:2: error: initializer element is not constant
     &afe440x_attr_in_intensity2_resistance.dev_attr.attr,
     ^
   drivers/iio/health/afe4403.c:207:2: error: (near initialization for 'afe440x_attributes[4]')
   drivers/iio/health/afe4403.c:208:3: error: 'afe440x_attr_in_intensity2_capacitance' undeclared here (not in a function)
     &afe440x_attr_in_intensity2_capacitance.dev_attr.attr,
      ^
   drivers/iio/health/afe4403.c:208:41: error: request for member 'dev_attr' in something not a structure or union
     &afe440x_attr_in_intensity2_capacitance.dev_attr.attr,
                                            ^
   drivers/iio/health/afe4403.c:208:50: error: request for member 'attr' in something not a structure or union
     &afe440x_attr_in_intensity2_capacitance.dev_attr.attr,
                                                     ^
   drivers/iio/health/afe4403.c:208:2: error: initializer element is not constant
     &afe440x_attr_in_intensity2_capacitance.dev_attr.attr,
     ^
   drivers/iio/health/afe4403.c:208:2: error: (near initialization for 'afe440x_attributes[5]')
   drivers/iio/health/afe4403.c:209:3: error: 'afe440x_attr_in_intensity3_resistance' undeclared here (not in a function)
     &afe440x_attr_in_intensity3_resistance.dev_attr.attr,
      ^
   drivers/iio/health/afe4403.c:209:40: error: request for member 'dev_attr' in something not a structure or union
     &afe440x_attr_in_intensity3_resistance.dev_attr.attr,
                                           ^
   drivers/iio/health/afe4403.c:209:49: error: request for member 'attr' in something not a structure or union
     &afe440x_attr_in_intensity3_resistance.dev_attr.attr,
                                                    ^
   drivers/iio/health/afe4403.c:209:2: error: initializer element is not constant
     &afe440x_attr_in_intensity3_resistance.dev_attr.attr,
     ^
   drivers/iio/health/afe4403.c:209:2: error: (near initialization for 'afe440x_attributes[6]')
   drivers/iio/health/afe4403.c:210:3: error: 'afe440x_attr_in_intensity3_capacitance' undeclared here (not in a function)
     &afe440x_attr_in_intensity3_capacitance.dev_attr.attr,
      ^
   drivers/iio/health/afe4403.c:210:41: error: request for member 'dev_attr' in something not a structure or union
     &afe440x_attr_in_intensity3_capacitance.dev_attr.attr,
                                            ^
   drivers/iio/health/afe4403.c:210:50: error: request for member 'attr' in something not a structure or union
     &afe440x_attr_in_intensity3_capacitance.dev_attr.attr,
                                                     ^
   drivers/iio/health/afe4403.c:210:2: error: initializer element is not constant
     &afe440x_attr_in_intensity3_capacitance.dev_attr.attr,
     ^
   drivers/iio/health/afe4403.c:210:2: error: (near initialization for 'afe440x_attributes[7]')
   drivers/iio/health/afe4403.c:211:3: error: 'afe440x_attr_in_intensity4_resistance' undeclared here (not in a function)
     &afe440x_attr_in_intensity4_resistance.dev_attr.attr,
      ^
   drivers/iio/health/afe4403.c:211:40: error: request for member 'dev_attr' in something not a structure or union
     &afe440x_attr_in_intensity4_resistance.dev_attr.attr,
                                           ^
   drivers/iio/health/afe4403.c:211:49: error: request for member 'attr' in something not a structure or union
     &afe440x_attr_in_intensity4_resistance.dev_attr.attr,
                                                    ^
   drivers/iio/health/afe4403.c:211:2: error: initializer element is not constant
     &afe440x_attr_in_intensity4_resistance.dev_attr.attr,
     ^
   drivers/iio/health/afe4403.c:211:2: error: (near initialization for 'afe440x_attributes[8]')
   drivers/iio/health/afe4403.c:212:3: error: 'afe440x_attr_in_intensity4_capacitance' undeclared here (not in a function)
     &afe440x_attr_in_intensity4_capacitance.dev_attr.attr,
      ^
   drivers/iio/health/afe4403.c:212:41: error: request for member 'dev_attr' in something not a structure or union
     &afe440x_attr_in_intensity4_capacitance.dev_attr.attr,
                                            ^
   drivers/iio/health/afe4403.c:212:50: error: request for member 'attr' in something not a structure or union
     &afe440x_attr_in_intensity4_capacitance.dev_attr.attr,
                                                     ^
   drivers/iio/health/afe4403.c:212:2: error: initializer element is not constant
     &afe440x_attr_in_intensity4_capacitance.dev_attr.attr,
     ^
   drivers/iio/health/afe4403.c:212:2: error: (near initialization for 'afe440x_attributes[9]')
..

vim +/dev_attr +205 drivers/iio/health/afe4403.c

eec96d1e2 Andrew F. Davis 2016-02-06   28  #include <linux/iio/sysfs.h>
eec96d1e2 Andrew F. Davis 2016-02-06   29  #include <linux/iio/buffer.h>
eec96d1e2 Andrew F. Davis 2016-02-06   30  #include <linux/iio/trigger.h>
eec96d1e2 Andrew F. Davis 2016-02-06   31  #include <linux/iio/triggered_buffer.h>
eec96d1e2 Andrew F. Davis 2016-02-06   32  #include <linux/iio/trigger_consumer.h>
eec96d1e2 Andrew F. Davis 2016-02-06   33  
eec96d1e2 Andrew F. Davis 2016-02-06  @34  #include "afe440x.h"
eec96d1e2 Andrew F. Davis 2016-02-06   35  
eec96d1e2 Andrew F. Davis 2016-02-06   36  #define AFE4403_DRIVER_NAME		"afe4403"
eec96d1e2 Andrew F. Davis 2016-02-06   37  
eec96d1e2 Andrew F. Davis 2016-02-06   38  /* AFE4403 Registers */
eec96d1e2 Andrew F. Davis 2016-02-06   39  #define AFE4403_TIAGAIN			0x20
eec96d1e2 Andrew F. Davis 2016-02-06   40  #define AFE4403_TIA_AMB_GAIN		0x21
eec96d1e2 Andrew F. Davis 2016-02-06   41  
b36e82576 Andrew F. Davis 2016-05-01   42  enum afe4403_fields {
b36e82576 Andrew F. Davis 2016-05-01   43  	/* Gains */
b36e82576 Andrew F. Davis 2016-05-01   44  	F_RF_LED1, F_CF_LED1,
b36e82576 Andrew F. Davis 2016-05-01   45  	F_RF_LED, F_CF_LED,
b36e82576 Andrew F. Davis 2016-05-01   46  
b36e82576 Andrew F. Davis 2016-05-01   47  	/* LED Current */
b36e82576 Andrew F. Davis 2016-05-01   48  	F_ILED1, F_ILED2,
b36e82576 Andrew F. Davis 2016-05-01   49  
b36e82576 Andrew F. Davis 2016-05-01   50  	/* sentinel */
b36e82576 Andrew F. Davis 2016-05-01   51  	F_MAX_FIELDS
b36e82576 Andrew F. Davis 2016-05-01   52  };
b36e82576 Andrew F. Davis 2016-05-01   53  
b36e82576 Andrew F. Davis 2016-05-01   54  static const struct reg_field afe4403_reg_fields[] = {
b36e82576 Andrew F. Davis 2016-05-01   55  	/* Gains */
b36e82576 Andrew F. Davis 2016-05-01   56  	[F_RF_LED1]	= REG_FIELD(AFE4403_TIAGAIN, 0, 2),
b36e82576 Andrew F. Davis 2016-05-01   57  	[F_CF_LED1]	= REG_FIELD(AFE4403_TIAGAIN, 3, 7),
b36e82576 Andrew F. Davis 2016-05-01   58  	[F_RF_LED]	= REG_FIELD(AFE4403_TIA_AMB_GAIN, 0, 2),
b36e82576 Andrew F. Davis 2016-05-01   59  	[F_CF_LED]	= REG_FIELD(AFE4403_TIA_AMB_GAIN, 3, 7),
b36e82576 Andrew F. Davis 2016-05-01   60  	/* LED Current */
b36e82576 Andrew F. Davis 2016-05-01   61  	[F_ILED1]	= REG_FIELD(AFE440X_LEDCNTRL, 0, 7),
b36e82576 Andrew F. Davis 2016-05-01   62  	[F_ILED2]	= REG_FIELD(AFE440X_LEDCNTRL, 8, 15),
b36e82576 Andrew F. Davis 2016-05-01   63  };
b36e82576 Andrew F. Davis 2016-05-01   64  
eec96d1e2 Andrew F. Davis 2016-02-06   65  /**
f59e6b5ae Andrew F. Davis 2016-05-01   66   * struct afe4403_data - AFE4403 device instance data
f59e6b5ae Andrew F. Davis 2016-05-01   67   * @dev: Device structure
f59e6b5ae Andrew F. Davis 2016-05-01   68   * @spi: SPI device handle
f59e6b5ae Andrew F. Davis 2016-05-01   69   * @regmap: Register map of the device
b36e82576 Andrew F. Davis 2016-05-01   70   * @fields: Register fields of the device
f59e6b5ae Andrew F. Davis 2016-05-01   71   * @regulator: Pointer to the regulator for the IC
f59e6b5ae Andrew F. Davis 2016-05-01   72   * @trig: IIO trigger for this device
f59e6b5ae Andrew F. Davis 2016-05-01   73   * @irq: ADC_RDY line interrupt number
eec96d1e2 Andrew F. Davis 2016-02-06   74   */
eec96d1e2 Andrew F. Davis 2016-02-06   75  struct afe4403_data {
eec96d1e2 Andrew F. Davis 2016-02-06   76  	struct device *dev;
eec96d1e2 Andrew F. Davis 2016-02-06   77  	struct spi_device *spi;
eec96d1e2 Andrew F. Davis 2016-02-06   78  	struct regmap *regmap;
b36e82576 Andrew F. Davis 2016-05-01   79  	struct regmap_field *fields[F_MAX_FIELDS];
eec96d1e2 Andrew F. Davis 2016-02-06   80  	struct regulator *regulator;
eec96d1e2 Andrew F. Davis 2016-02-06   81  	struct iio_trigger *trig;
eec96d1e2 Andrew F. Davis 2016-02-06   82  	int irq;
eec96d1e2 Andrew F. Davis 2016-02-06   83  };
eec96d1e2 Andrew F. Davis 2016-02-06   84  
eec96d1e2 Andrew F. Davis 2016-02-06   85  enum afe4403_chan_id {
24b9dea76 Andrew F. Davis 2016-05-01   86  	LED2 = 1,
24b9dea76 Andrew F. Davis 2016-05-01   87  	ALED2,
eec96d1e2 Andrew F. Davis 2016-02-06   88  	LED1,
eec96d1e2 Andrew F. Davis 2016-02-06   89  	ALED1,
eec96d1e2 Andrew F. Davis 2016-02-06   90  	LED2_ALED2,
24b9dea76 Andrew F. Davis 2016-05-01   91  	LED1_ALED1,
eec96d1e2 Andrew F. Davis 2016-02-06   92  };
eec96d1e2 Andrew F. Davis 2016-02-06   93  
b36e82576 Andrew F. Davis 2016-05-01   94  static const unsigned int afe4403_channel_values[] = {
b36e82576 Andrew F. Davis 2016-05-01   95  	[LED2] = AFE440X_LED2VAL,
b36e82576 Andrew F. Davis 2016-05-01   96  	[ALED2] = AFE440X_ALED2VAL,
b36e82576 Andrew F. Davis 2016-05-01   97  	[LED1] = AFE440X_LED1VAL,
b36e82576 Andrew F. Davis 2016-05-01   98  	[ALED1] = AFE440X_ALED1VAL,
b36e82576 Andrew F. Davis 2016-05-01   99  	[LED2_ALED2] = AFE440X_LED2_ALED2VAL,
b36e82576 Andrew F. Davis 2016-05-01  100  	[LED1_ALED1] = AFE440X_LED1_ALED1VAL,
b36e82576 Andrew F. Davis 2016-05-01  101  };
b36e82576 Andrew F. Davis 2016-05-01  102  
b36e82576 Andrew F. Davis 2016-05-01  103  static const unsigned int afe4403_channel_leds[] = {
3ff34ee2a Andrew F. Davis 2016-05-01  104  	[LED2] = F_ILED2,
3ff34ee2a Andrew F. Davis 2016-05-01  105  	[LED1] = F_ILED1,
eec96d1e2 Andrew F. Davis 2016-02-06  106  };
eec96d1e2 Andrew F. Davis 2016-02-06  107  
eec96d1e2 Andrew F. Davis 2016-02-06  108  static const struct iio_chan_spec afe4403_channels[] = {
eec96d1e2 Andrew F. Davis 2016-02-06  109  	/* ADC values */
24b9dea76 Andrew F. Davis 2016-05-01 @110  	AFE440X_INTENSITY_CHAN(LED2, 0),
24b9dea76 Andrew F. Davis 2016-05-01  111  	AFE440X_INTENSITY_CHAN(ALED2, 0),
24b9dea76 Andrew F. Davis 2016-05-01  112  	AFE440X_INTENSITY_CHAN(LED1, 0),
24b9dea76 Andrew F. Davis 2016-05-01  113  	AFE440X_INTENSITY_CHAN(ALED1, 0),
24b9dea76 Andrew F. Davis 2016-05-01  114  	AFE440X_INTENSITY_CHAN(LED2_ALED2, 0),
24b9dea76 Andrew F. Davis 2016-05-01  115  	AFE440X_INTENSITY_CHAN(LED1_ALED1, 0),
eec96d1e2 Andrew F. Davis 2016-02-06  116  	/* LED current */
3ff34ee2a Andrew F. Davis 2016-05-01  117  	AFE440X_CURRENT_CHAN(LED2),
3ff34ee2a Andrew F. Davis 2016-05-01  118  	AFE440X_CURRENT_CHAN(LED1),
eec96d1e2 Andrew F. Davis 2016-02-06  119  };
eec96d1e2 Andrew F. Davis 2016-02-06  120  
eec96d1e2 Andrew F. Davis 2016-02-06  121  static const struct afe440x_val_table afe4403_res_table[] = {
eec96d1e2 Andrew F. Davis 2016-02-06  122  	{ 500000 }, { 250000 }, { 100000 }, { 50000 },
eec96d1e2 Andrew F. Davis 2016-02-06  123  	{ 25000 }, { 10000 }, { 1000000 }, { 0 },
eec96d1e2 Andrew F. Davis 2016-02-06  124  };
1276187c5 Andrew F. Davis 2016-05-01  125  AFE440X_TABLE_ATTR(in_intensity_resistance_available, afe4403_res_table);
eec96d1e2 Andrew F. Davis 2016-02-06  126  
eec96d1e2 Andrew F. Davis 2016-02-06  127  static const struct afe440x_val_table afe4403_cap_table[] = {
eec96d1e2 Andrew F. Davis 2016-02-06  128  	{ 0, 5000 }, { 0, 10000 }, { 0, 20000 }, { 0, 25000 },
eec96d1e2 Andrew F. Davis 2016-02-06  129  	{ 0, 30000 }, { 0, 35000 }, { 0, 45000 }, { 0, 50000 },
eec96d1e2 Andrew F. Davis 2016-02-06  130  	{ 0, 55000 }, { 0, 60000 }, { 0, 70000 }, { 0, 75000 },
eec96d1e2 Andrew F. Davis 2016-02-06  131  	{ 0, 80000 }, { 0, 85000 }, { 0, 95000 }, { 0, 100000 },
eec96d1e2 Andrew F. Davis 2016-02-06  132  	{ 0, 155000 }, { 0, 160000 }, { 0, 170000 }, { 0, 175000 },
eec96d1e2 Andrew F. Davis 2016-02-06  133  	{ 0, 180000 }, { 0, 185000 }, { 0, 195000 }, { 0, 200000 },
eec96d1e2 Andrew F. Davis 2016-02-06  134  	{ 0, 205000 }, { 0, 210000 }, { 0, 220000 }, { 0, 225000 },
eec96d1e2 Andrew F. Davis 2016-02-06  135  	{ 0, 230000 }, { 0, 235000 }, { 0, 245000 }, { 0, 250000 },
eec96d1e2 Andrew F. Davis 2016-02-06  136  };
1276187c5 Andrew F. Davis 2016-05-01  137  AFE440X_TABLE_ATTR(in_intensity_capacitance_available, afe4403_cap_table);
eec96d1e2 Andrew F. Davis 2016-02-06  138  
eec96d1e2 Andrew F. Davis 2016-02-06  139  static ssize_t afe440x_show_register(struct device *dev,
eec96d1e2 Andrew F. Davis 2016-02-06  140  				     struct device_attribute *attr,
eec96d1e2 Andrew F. Davis 2016-02-06  141  				     char *buf)
eec96d1e2 Andrew F. Davis 2016-02-06  142  {
eec96d1e2 Andrew F. Davis 2016-02-06  143  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
eec96d1e2 Andrew F. Davis 2016-02-06  144  	struct afe4403_data *afe = iio_priv(indio_dev);
eec96d1e2 Andrew F. Davis 2016-02-06  145  	struct afe440x_attr *afe440x_attr = to_afe440x_attr(attr);
81f517270 Andrew F. Davis 2016-05-01  146  	unsigned int reg_val;
eec96d1e2 Andrew F. Davis 2016-02-06  147  	int vals[2];
81f517270 Andrew F. Davis 2016-05-01  148  	int ret;
eec96d1e2 Andrew F. Davis 2016-02-06  149  
b36e82576 Andrew F. Davis 2016-05-01  150  	ret = regmap_field_read(afe->fields[afe440x_attr->field], &reg_val);
eec96d1e2 Andrew F. Davis 2016-02-06  151  	if (ret)
eec96d1e2 Andrew F. Davis 2016-02-06  152  		return ret;
eec96d1e2 Andrew F. Davis 2016-02-06  153  
81f517270 Andrew F. Davis 2016-05-01  154  	if (reg_val >= afe440x_attr->table_size)
81f517270 Andrew F. Davis 2016-05-01  155  		return -EINVAL;
81f517270 Andrew F. Davis 2016-05-01  156  
eec96d1e2 Andrew F. Davis 2016-02-06  157  	vals[0] = afe440x_attr->val_table[reg_val].integer;
eec96d1e2 Andrew F. Davis 2016-02-06  158  	vals[1] = afe440x_attr->val_table[reg_val].fract;
eec96d1e2 Andrew F. Davis 2016-02-06  159  
81f517270 Andrew F. Davis 2016-05-01  160  	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, vals);
eec96d1e2 Andrew F. Davis 2016-02-06  161  }
eec96d1e2 Andrew F. Davis 2016-02-06  162  
eec96d1e2 Andrew F. Davis 2016-02-06  163  static ssize_t afe440x_store_register(struct device *dev,
eec96d1e2 Andrew F. Davis 2016-02-06  164  				      struct device_attribute *attr,
eec96d1e2 Andrew F. Davis 2016-02-06  165  				      const char *buf, size_t count)
eec96d1e2 Andrew F. Davis 2016-02-06  166  {
eec96d1e2 Andrew F. Davis 2016-02-06  167  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
eec96d1e2 Andrew F. Davis 2016-02-06  168  	struct afe4403_data *afe = iio_priv(indio_dev);
eec96d1e2 Andrew F. Davis 2016-02-06  169  	struct afe440x_attr *afe440x_attr = to_afe440x_attr(attr);
eec96d1e2 Andrew F. Davis 2016-02-06  170  	int val, integer, fract, ret;
eec96d1e2 Andrew F. Davis 2016-02-06  171  
eec96d1e2 Andrew F. Davis 2016-02-06  172  	ret = iio_str_to_fixpoint(buf, 100000, &integer, &fract);
eec96d1e2 Andrew F. Davis 2016-02-06  173  	if (ret)
eec96d1e2 Andrew F. Davis 2016-02-06  174  		return ret;
eec96d1e2 Andrew F. Davis 2016-02-06  175  
eec96d1e2 Andrew F. Davis 2016-02-06  176  	for (val = 0; val < afe440x_attr->table_size; val++)
eec96d1e2 Andrew F. Davis 2016-02-06  177  		if (afe440x_attr->val_table[val].integer == integer &&
eec96d1e2 Andrew F. Davis 2016-02-06  178  		    afe440x_attr->val_table[val].fract == fract)
eec96d1e2 Andrew F. Davis 2016-02-06  179  			break;
eec96d1e2 Andrew F. Davis 2016-02-06  180  	if (val == afe440x_attr->table_size)
eec96d1e2 Andrew F. Davis 2016-02-06  181  		return -EINVAL;
eec96d1e2 Andrew F. Davis 2016-02-06  182  
b36e82576 Andrew F. Davis 2016-05-01  183  	ret = regmap_field_write(afe->fields[afe440x_attr->field], val);
eec96d1e2 Andrew F. Davis 2016-02-06  184  	if (ret)
eec96d1e2 Andrew F. Davis 2016-02-06  185  		return ret;
eec96d1e2 Andrew F. Davis 2016-02-06  186  
eec96d1e2 Andrew F. Davis 2016-02-06  187  	return count;
eec96d1e2 Andrew F. Davis 2016-02-06  188  }
eec96d1e2 Andrew F. Davis 2016-02-06  189  
1276187c5 Andrew F. Davis 2016-05-01  190  static AFE440X_ATTR(in_intensity1_resistance, F_RF_LED, afe4403_res_table);
1276187c5 Andrew F. Davis 2016-05-01  191  static AFE440X_ATTR(in_intensity1_capacitance, F_CF_LED, afe4403_cap_table);
eec96d1e2 Andrew F. Davis 2016-02-06  192  
1276187c5 Andrew F. Davis 2016-05-01  193  static AFE440X_ATTR(in_intensity2_resistance, F_RF_LED, afe4403_res_table);
1276187c5 Andrew F. Davis 2016-05-01  194  static AFE440X_ATTR(in_intensity2_capacitance, F_CF_LED, afe4403_cap_table);
1276187c5 Andrew F. Davis 2016-05-01  195  
1276187c5 Andrew F. Davis 2016-05-01  196  static AFE440X_ATTR(in_intensity3_resistance, F_RF_LED1, afe4403_res_table);
1276187c5 Andrew F. Davis 2016-05-01  197  static AFE440X_ATTR(in_intensity3_capacitance, F_CF_LED1, afe4403_cap_table);
1276187c5 Andrew F. Davis 2016-05-01  198  
1276187c5 Andrew F. Davis 2016-05-01  199  static AFE440X_ATTR(in_intensity4_resistance, F_RF_LED1, afe4403_res_table);
1276187c5 Andrew F. Davis 2016-05-01 @200  static AFE440X_ATTR(in_intensity4_capacitance, F_CF_LED1, afe4403_cap_table);
eec96d1e2 Andrew F. Davis 2016-02-06  201  
eec96d1e2 Andrew F. Davis 2016-02-06  202  static struct attribute *afe440x_attributes[] = {
1276187c5 Andrew F. Davis 2016-05-01 @203  	&dev_attr_in_intensity_resistance_available.attr,
1276187c5 Andrew F. Davis 2016-05-01 @204  	&dev_attr_in_intensity_capacitance_available.attr,
1276187c5 Andrew F. Davis 2016-05-01 @205  	&afe440x_attr_in_intensity1_resistance.dev_attr.attr,
1276187c5 Andrew F. Davis 2016-05-01  206  	&afe440x_attr_in_intensity1_capacitance.dev_attr.attr,
1276187c5 Andrew F. Davis 2016-05-01  207  	&afe440x_attr_in_intensity2_resistance.dev_attr.attr,
1276187c5 Andrew F. Davis 2016-05-01  208  	&afe440x_attr_in_intensity2_capacitance.dev_attr.attr,

:::::: The code at line 205 was first introduced by commit
:::::: 1276187c5261217aa9cc23ec153e0e903181c16b iio: health/afe440x: Make gain settings a modifier for the stages

:::::: TO: Andrew F. Davis <afd@ti.com>
:::::: CC: Jonathan Cameron <jic23@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--0OAP2g/MAC+5xKAE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
v4MGAwA=

--0OAP2g/MAC+5xKAE--
