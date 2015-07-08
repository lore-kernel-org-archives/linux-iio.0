Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <CAKv63usGO4DxYhx-Sz_BugWmi_ztJF7=ce035Wr1EZw+-wMOfg@mail.gmail.com>
References: <CAKv63usGO4DxYhx-Sz_BugWmi_ztJF7=ce035Wr1EZw+-wMOfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 0/1] iio: mlx90614: Implement filter configuration
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 08 Jul 2015 17:59:52 +0100
To: Crt Mori <cmo@melexis.com>,linux-iio@vger.kernel.org,Peter Meerwald <pmeerw@pmeerw.net>,=?ISO-8859-1?Q?Vianney_le_Cl=E9ment_de_Saint-Marcq?= <vianney.leclement@essensium.com>,Johnathan Iain Cameron <jic23@kernel.org>
Message-ID: <BBC430FE-127C-493F-B3AF-1ED207261F9C@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 7 July 2015 15:44:51 BST, Crt Mori <cmo@melexis.com> wrote:
>Implemented FIR and IIR filter configuration which are located
>within the configuration register of EEPROM. I have used the
>IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY for FIR settings and
>IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY for IIR settings just
>to reuse IIO_CHAN_INFO structure with closes resemblance of the
>settings (although it would have been better to drop that
>3DB_FREQUENCY part).
>
>The diff is made towards togreg branch as that branch seems to have the
>most recent updates of mlx90614 driver

I am having a rather silly week, hence very brief reply from a train. Sorry about that,!

Using existing abi in a non documented way is always a bad idea.  Either work out
how to fit in with what is there fully or if that isn't possible propose new ABI for 
what you need.

Will have to postpone reading actual code for a few days. Train arrived

J
>
>Signed-off-by: Crt Mori <cmo@melexis.com>
>---
>diff --git a/drivers/iio/temperature/mlx90614.c
>b/drivers/iio/temperature/mlx90614.c
>index 909278a..d767d2f 100644
>--- a/drivers/iio/temperature/mlx90614.c
>+++ b/drivers/iio/temperature/mlx90614.c
>@@ -20,7 +20,6 @@
>* always has a pull-up so we do not need an extra GPIO to drive it
>high.
>If
>  * the "wakeup" GPIO is not given, power management will be disabled.
>  *
>- * TODO: filter configuration
>  */
>
> #include <linux/err.h>
>@@ -79,6 +78,25 @@ struct mlx90614_data {
>  unsigned long ready_timestamp; /* in jiffies */
> };
>
>+/* Allowed percentage values for IIR filtering */
>+static const u8 mlx90614_iir_values[] = {50, 25, 17, 13, 100, 80, 67,
>57};
>+
>+/*
>+ * Find the IIR value inside mlx90614_iir_values array and return its
>position
>+ */
>+static inline s32 mlx90614_iir_search(int value)
>+{
>+ u8 i;
>+ if (value < 0 || value > 100)
>+ return -EINVAL;
>+
>+ for (i=0; i < ARRAY_SIZE(mlx90614_iir_values); ++i) {
>+ if (value == mlx90614_iir_values[i])
>+ return i;
>+ }
>+ return -EINVAL;
>+}
>+
> /*
>  * Erase an address and write word.
>  * The mutex must be locked before calling.
>@@ -236,6 +254,31 @@ static int mlx90614_read_raw(struct iio_dev
>*indio_dev,
>  *val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
>  }
>  return IIO_VAL_INT_PLUS_NANO;
>+ case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* FIR setting */
>+ mlx90614_power_get(data, false);
>+ mutex_lock(&data->lock);
>+ ret = i2c_smbus_read_word_data(data->client,MLX90614_CONFIG);
>+ mutex_unlock(&data->lock);
>+ mlx90614_power_put(data);
>+
>+ if (ret < 0)
>+ return ret;
>+
>+ *val = (ret & MLX90614_CONFIG_FIR_MASK) >>
>+ MLX90614_CONFIG_FIR_SHIFT;
>+ return IIO_VAL_INT;
>+ case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY: /* IIR setting */
>+ mlx90614_power_get(data, false);
>+ mutex_lock(&data->lock);
>+ ret = i2c_smbus_read_word_data(data->client,MLX90614_CONFIG);
>+ mutex_unlock(&data->lock);
>+ mlx90614_power_put(data);
>+
>+ if (ret < 0)
>+ return ret;
>+
>+ *val = mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MASK];
>+ return IIO_VAL_INT;
>  default:
>  return -EINVAL;
>  }
>@@ -263,6 +306,52 @@ static int mlx90614_write_raw(struct iio_dev
>*indio_dev,
>  mlx90614_power_put(data);
>
>  return ret;
>+ case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* FIR Filter */
>+ if (val < 0 || val > 7)
>+ return -EINVAL;
>+
>+ mlx90614_power_get(data, false);
>+ mutex_lock(&data->lock);
>+
>+ /* CONFIG register values must not be changed so we must read
>+ * them before we actually write changes */
>+ ret = i2c_smbus_read_word_data(data->client,MLX90614_CONFIG);
>+ if (ret >= 0)
>+ {
>+ /* Write changed values */
>+ ret = mlx90614_write_word(data->client, MLX90614_CONFIG,
>+  (val << MLX90614_CONFIG_FIR_SHIFT) |
>+  ((u16) ret & (~((u16) MLX90614_CONFIG_FIR_MASK))));
>+ }
>+ mutex_unlock(&data->lock);
>+ mlx90614_power_put(data);
>+
>+ return ret;
>+ case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY: /* IIR Filter */
>+ ret = mlx90614_iir_search(val);
>+ if (ret < 0)
>+ return ret;
>+ /* If there is no error, then we have a sensor equivalent value
>+ * in ret. We need to store it temporary to val, as we still
>+ * have more data to save in ret before we can actually write */
>+ val = ret;
>+
>+ mlx90614_power_get(data, false);
>+ mutex_lock(&data->lock);
>+ /* CONFIG register values must not be changed so we must read
>+ * them before we actually write changes*/
>+ ret = i2c_smbus_read_word_data(data->client,MLX90614_CONFIG);
>+ if (ret >= 0)
>+ {
>+ /* Write changed values */
>+ ret = mlx90614_write_word(data->client, MLX90614_CONFIG,
>+  (val << MLX90614_CONFIG_IIR_SHIFT) |
>+  ((u16) ret & (~(u16) MLX90614_CONFIG_IIR_MASK)));
>+ }
>+ mutex_unlock(&data->lock);
>+ mlx90614_power_put(data);
>+
>+ return ret;
>  default:
>  return -EINVAL;
>  }
>@@ -275,6 +364,10 @@ static int mlx90614_write_raw_get_fmt(struct
>iio_dev
>*indio_dev,
>  switch (mask) {
>  case IIO_CHAN_INFO_CALIBEMISSIVITY:
>  return IIO_VAL_INT_PLUS_NANO;
>+ case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>+ return IIO_VAL_INT_PLUS_MICRO;
>+ case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
>+ return IIO_VAL_INT_PLUS_MICRO;
>  default:
>  return -EINVAL;
>  }
>@@ -294,7 +387,9 @@ static const struct iio_chan_spec
>mlx90614_channels[] =
>{
>  .modified = 1,
>  .channel2 = IIO_MOD_TEMP_OBJECT,
>  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>-    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
>+    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
>+ BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
>+ BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),
>  .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>     BIT(IIO_CHAN_INFO_SCALE),
>  },
>@@ -305,7 +400,9 @@ static const struct iio_chan_spec
>mlx90614_channels[] =
>{
>  .channel = 1,
>  .channel2 = IIO_MOD_TEMP_OBJECT,
>  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>-    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
>+    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
>+ BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
>+ BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),
>  .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>     BIT(IIO_CHAN_INFO_SCALE),
>  },

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
