Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA6386550
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904362; cv=pass; b=trgftIVCJOfLr6Hbm65KWn4bYm5hIEb+ilUMFcD0SEBkMZ2SS7wvyhsDO9q9xMdo9bAv2IwrR+Rb6nLEUlQw8Z3q6lyWj0VAvrTytO9FDEVQ5gfuyDLzWa10Pmy/GJ/ZQYnDGO3pTbtyMogXWqkO7UTSDiZnUtpIQdv/SD5rGLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904362; c=relaxed/simple;
	bh=oRRYSD6k5dzbRPBmS2Ck99WxozEL9u76avr57pua1Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0QEwufIebyZ4OK6pVxpEZW9/00MrJx2c1hEjE62GtcU3rDiPH181g3AlVzyE0usZPIEZqz/glP/ksaQJqxis7Izkg1TUxMAYd/UuTgkBJCuRrxED6rPUQRUwKKoni8FX6mCZVxgOz/rD+2qVgv8wIwKKeW/ObhoxNIrDtYFSBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pp3g+Y7X; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pp3g+Y7X"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so34628615e9.3
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 00:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780904357; cv=none;
        d=google.com; s=arc-20240605;
        b=ItbwK+qZWmQi+4fdsuaNpikMcYRoDSDpggiZyduwbFiDWg8O/4gw3wt51fMzoPq6an
         KFP2g8rI/+NdbjRfIWbn6oW6v8wJf+OKRKuh7MGHvYOQICZKzXRmbJNxLx5Smh05sL8f
         zh8JCuVgeFu3NCVKsD+KGd49P2yQuKEF5Ql8LfM43lI0JTtS+sdVChZaYCOklXo+REIz
         DBSNupwEyICxEBRDVjetI2T1GBe3Cf7pACCnaZwYnq6tAUtBRfDi4kUcRyxID0Gt2UxS
         YlfBrCvaJh3kzNAM/3tnfDsPuAuIgIdiabsZyclqGjFXkaHQuLRqVgxU50QhNPPw/Hb7
         caCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kwPMsqPoX9lSCyOolO/DVXxaF7DVbLqSxuUxI41Q5ao=;
        fh=aY4WD0+Sk58Cus5m768wrUgk3BgX8E6lSNAph5OmG9Q=;
        b=MpOX5VPY5mbVxBuN/O+Nzq+smuDBy3yau6NBUvz8DpeHfI2BcQB9fDe14YY4FTGHop
         ROxowpmduZZJngsjtQ+NwKUPHBKmE3nuuoM4eZ3dSLqBluump2UmbMsxFvB1rewJzUYY
         DoMoiygaUfvgmKp6AqkeCaUQZKetnaBoWVjNviHU4bF3/T50imovMRhlqMZxb1wO5Aqx
         1u2IAVjaN8XLq9p0qaOI0UqznnFtR/Ne90Ntpj87ou3G62sCazfhK280QUmn9xjrLxYR
         6ilM1wohUMkgRfaKpnzmXYxebSg/V3BJORCWCex5oWL5nCMbB6G6q+Nu77BBFRRBiJ0J
         29LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780904357; x=1781509157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kwPMsqPoX9lSCyOolO/DVXxaF7DVbLqSxuUxI41Q5ao=;
        b=pp3g+Y7Xx+wwfEuNoZNyhPLFeZFvlrPkeN8AuB4qBCgzPt5F7tkyj48HEv56NNt3fx
         LtGj+w2GxFaDZ8OBp18zQKxN5X2mxUoCdJ3wNYAhxFao55JCvnr3cjwUlzEbYYW4EBo3
         QoLedd7E+nvgLcj235Gaw1q+9GnDF9DAlFTIBI4xHKq5jRj0d3m3WQTgxbEfkp0fqxJg
         g/qfqZIJVkZCiKYWtFY8Jtr4ryes6HTdPVb/voSv3Rb6E6Q7vd5oehI/kZHdkFRIvlgW
         h/O8YMoOBrAmB1OTVCN+1acU+YuQFbtv2JzMCCewwd3dFntFMxbG39p2s9+yQ84J/N7s
         Ub7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780904357; x=1781509157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwPMsqPoX9lSCyOolO/DVXxaF7DVbLqSxuUxI41Q5ao=;
        b=J9RlGA1n6l5vBEe095ZVRQGT/C7++1voxOxgvp+GsGW5EOzLDHWr+WCv6mohACnDYA
         2+8ZJEhlPhKXP757NoDqkSi6Y866HgiPIfPqMjtTCcwUvIxSTWch47SkQpPo0cCkvOOT
         xISKhh7Nx9GVpFKpgb4fNcvcbeyd/KBej+xjqUVuqOgJRW6DiLMH2RDcKhsJ2vkQ7bwU
         1q8VtTfVEKRwnMvcHjgysRGVFuXWvlXGmN19h7txZ88MyIIIrPMLTIWVuI2FCBzofQTJ
         cMosa7fgePnEp0Hy69AjS7gm02dbnlr92AbhMws8MgYH6t0SZ9ll2N9mI+R257XklMfo
         10yA==
X-Gm-Message-State: AOJu0Yx0L7e4Hnn5VHwodMA8BCi7idMWfFvN6HTup7opfl5CpS/Fwc5F
	l3fopfju9TgmMtSGLzR6v3mZsH5WLnG0teWUl1//9mCsBeIsIGDg4rRa6dpwckXGk6VRwn0YwRg
	0MtjwpV0qc9KFC6hITyfCokWGYBjqasL48OJpkVU=
X-Gm-Gg: Acq92OGuX5JXfzIAe66AnU+sdkqg6J2axvJGkvz1d9gYvHbCb9SEShDsFyxJXzKDAmm
	ZpXgLhmln1W2Hi/wYuTfn/AHFprCM0Q3Tz2P0OVyqeEG5YL3bk+exHoTpBv+cXvalCTfNz3vjSA
	q/i9+aZP5Nav4WDQoq1a/RkgBnq4NlAVwE9s78eCqNLcv77RhhP7T3gaNQaxJ9Ro9C7aXtNj7AF
	jfuMQU0lxhfatQXIVe/UxadDjNt8UQCkZAuwHN3/t5Y4T1OnDh32CiMclFNlrT+/0J7rp6ivRgP
	a0He84v8Orpu3fM3HEs9YaE6PumurtnUBYHVayoxMk3AvWWDZFuvAjgTwtYdUBtEB/Zd7UNCE6C
	M7mZRHrR3h4zgFYAXxHOFji/g+bJN97AvJJq6m07+Q/4D4Mj6EY2T1lI89eYJvEsMZEvP6LoAWe
	ACp0Uls1T7L9cYWlcr
X-Received: by 2002:a05:600c:4708:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-490c2604735mr230946075e9.20.1780904356973; Mon, 08 Jun 2026
 00:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com> <20260607183542.368184-4-jakubszczudlo40@gmail.com>
In-Reply-To: <20260607183542.368184-4-jakubszczudlo40@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 8 Jun 2026 09:39:07 +0200
X-Gm-Features: AVVi8CfWsjBpArxisQgZQ9LCKVhWbz0XmwUSuc_Rk1mMgiQYYClWPqpXkoZdVgc
Message-ID: <CALoEA-xWB226gf01OdB5LBMRqrds=b2UN+DmXJdH1j6rq1c5-A@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100 driver
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt@analog.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mike.looijmans@topic.nl, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jorge.marques@analog.com, 
	antoniu.miclaus@analog.com, mazziesaccount@gmail.com, 
	jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz, wens@kernel.org, 
	sakari.ailus@linux.intel.com, linusw@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

various comments inline, some nitpicks and some more serious.

Josh

On Sun, 7 Jun 2026 at 20:38, Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:
>
> From: jszczudlo <jakubszczudlo40@gmail.com>
>
> add ADS1100 support

Wrap the commit message to 72 characters per line, this is too
short.

> make changing gain and datarate wait for new reading
> fix unbalanced regulator disable when removing in singleshot mode

Additionally, write the commit messages as regular sentences, not
a list of changes.

>
> Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>

Ensure that your full name is in the Signed-off-by tag (this goes for all
patches in this series).

> ---
>  drivers/iio/adc/ti-ads1100.c | 165 ++++++++++++++++++++++++++---------
>  1 file changed, 126 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index aa8946063c7d..11d6fe1e8abc 100644
> --- a/drivers/iio/adc/ti-ads1100.c
> +++ b/drivers/iio/adc/ti-ads1100.c
> @@ -5,18 +5,15 @@
>   * Copyright (c) 2023, Topic Embedded Products
>   *
>   * Datasheet: https://www.ti.com/lit/gpn/ads1100
> - * IIO driver for ADS1100 and ADS1000 ADC 16-bit I2C
> + * IIO driver for ADS1100, ADS1000 and ADS1110 ADC 16-bit I2C
>   */
>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> -#include <linux/cleanup.h>
> -#include <linux/delay.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
>  #include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
> -#include <linux/property.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/units.h>

This should go as a separate patch (or part of a cleanup series). Not only
it's undocumented in the commit message, it's also unrelated to adding
support for a new device.

> @@ -39,17 +36,39 @@
>  #define        ADS1100_SINGLESHOT      ADS1100_CFG_SC
>
>  #define ADS1100_SLEEP_DELAY_MS 2000
> +#define ADS1110_REFERENCE_VOLTAGE_MICROVOLT 2048000
> +
> +/* Timeout based on the minimum sample rate of 8 SPS (7500000us) */
> +#define ADS11x0_MAX_DRDY_TIMEOUT       7500000
>
>  static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
> +static const int ads1110_data_rate[] = { 240, 60, 30, 15 };
>  static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
>
> +struct ads11x0_config {
> +       const int *data_rate;
> +       bool has_reference_voltage;
> +};
> +
> +static const struct ads11x0_config ads1100_config = {
> +       .data_rate = ads1100_data_rate,
> +       .has_reference_voltage = false,
> +};
> +
> +static const struct ads11x0_config ads1110_config = {
> +       .data_rate = ads1110_data_rate,
> +       .has_reference_voltage = true,
> +};
> +
>  struct ads1100_data {
>         struct i2c_client *client;
>         struct regulator *reg_vdd;
>         struct mutex lock;
>         int scale_avail[2 * 4]; /* 4 gain settings */
>         u8 config;
> -       bool supports_data_rate; /* Only the ADS1100 can select the rate */
> +       bool supports_data_rate; /* Only the ADS1100/ADS1110 can select the rate */
> +       bool has_reference_voltage; /* The ADS1110 has an internal reference, so fixed scale */
> +       const int *data_rate;
>  };

Have you used pahole to ensure this struct layout is ideal? I'd
move the data_rate pointer up to the larger types.

>  static const struct iio_chan_spec ads1100_channel = {
> @@ -59,12 +78,6 @@ static const struct iio_chan_spec ads1100_channel = {
>             BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
>         .info_mask_shared_by_all_available =
>             BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -       .scan_type = {
> -                     .sign = 's',
> -                     .realbits = 16,
> -                     .storagebits = 16,
> -                     .endianness = IIO_CPU,
> -                      },
>         .datasheet_name = "AIN",
>  };
>
> @@ -85,6 +98,50 @@ static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
>         return 0;
>  };
>
> +static int ads11x0_get_voltage_microvolts(struct ads1100_data *data)
> +{
> +       if (data->has_reference_voltage)
> +               return ADS1110_REFERENCE_VOLTAGE_MICROVOLT;
> +       else
> +               return regulator_get_voltage(data->reg_vdd);
> +}
> +
> +static int ads11x0_get_voltage_milivolts(struct ads1100_data *data)
> +{
> +       return ads11x0_get_voltage_microvolts(data) / (MICRO / MILLI);
> +}
> +
> +static bool ads11x0_new_data_ready(struct ads1100_data *data)
> +{
> +       int ret;
> +       u8 buffer[3];
> +
> +       ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> +       if (ret < sizeof(buffer)) {

Sashiko raises an issue here. sizeof returns a size_t, therefore the compiler
will promote ret to a size_t, wrapping any potential negative error value to
a large positive value, throwing away the error.

> +               dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +               return 0;
> +       }
> +
> +       int return_val = FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
> +
> +       return return_val;
> +}
> +
> +static int ads11x0_poll_data_ready(struct ads1100_data *data)
> +{
> +       bool data_ready;
> +       u8 buffer[3];
> +       int datarate = data->data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
> +       unsigned long wait_time = DIV_ROUND_CLOSEST(MICRO, 5 * datarate);

Reverse Christmas tree order please. This goes for all new functions
and variable
declarations.

> +
> +       /* To be sure that polled value will have value after config change */
> +       i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));

Add a check here as well maybe.

> +       return read_poll_timeout(ads11x0_new_data_ready, data_ready,
> +                                !data_ready, wait_time,
> +                                ADS11x0_MAX_DRDY_TIMEOUT, false, data);
> +}
> +
>  static int ads1100_data_bits(struct ads1100_data *data)
>  {
>         return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
> @@ -105,9 +162,10 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
>
>         ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
>
> +       pm_runtime_mark_last_busy(&data->client->dev);

AFAIK pm_runtime_put_autosuspend automatically calls mark_last_busy
when executed, so this is probably unnecessary. Additionally, this has nothing
to do with adding new device support.

>         pm_runtime_put_autosuspend(&data->client->dev);
>
> -       if (ret < 0) {
> +       if (ret < sizeof(buffer)) {

Same issue with type promotion here.

>                 dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
>                 return ret;
>         }
> @@ -127,7 +185,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
>  {
>         int microvolts;
>         int gain;
> -
> +       int ret;

Newline here.

>         /* With Vdd between 2.7 and 5V, the scale is always below 1 */
>         if (val)
>                 return -EINVAL;
> @@ -135,7 +193,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
>         if (!val2)
>                 return -EINVAL;
>
> -       microvolts = regulator_get_voltage(data->reg_vdd);
> +       microvolts = ads11x0_get_voltage_microvolts(data);
>         /*
>          * val2 is in 'micro' units, n = val2 / 1000000
>          * result must be millivolts, d = microvolts / 1000
> @@ -147,34 +205,49 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
>         if (gain < BIT(0) || gain > BIT(3))
>                 return -EINVAL;
>
> +       ret = pm_runtime_resume_and_get(&data->client->dev);
> +       if (ret < 0)
> +               return ret;
> +
>         ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);
>
> -       return 0;
> +       ret = ads11x0_poll_data_ready(data);
> +
> +       pm_runtime_mark_last_busy(&data->client->dev);

Same issue with mark_last_busy being called automatically.

> +       pm_runtime_put_autosuspend(&data->client->dev);
> +
> +       return ret;
>  }
>
>  static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
>  {
>         unsigned int i;
>         unsigned int size;
> +       int ret;
>
>         size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
>         for (i = 0; i < size; i++) {
> -               if (ads1100_data_rate[i] == rate)
> -                       return ads1100_set_config_bits(data, ADS1100_DR_MASK,
> -                                                      FIELD_PREP(ADS1100_DR_MASK, i));
> +               if (data->data_rate[i] == rate) {
> +                       ret = pm_runtime_resume_and_get(&data->client->dev);
> +                       if (ret < 0)
> +                               return ret;
> +
> +                       ads1100_set_config_bits(data, ADS1100_DR_MASK,
> +                                               FIELD_PREP(ADS1100_DR_MASK, i));
> +                       ret = ads11x0_poll_data_ready(data);
> +
> +                       pm_runtime_mark_last_busy(&data->client->dev);
> +                       pm_runtime_put_autosuspend(&data->client->dev);
> +                       return ret;
> +               }
>         }
>
>         return -EINVAL;
>  }
>
> -static int ads1100_get_vdd_millivolts(struct ads1100_data *data)
> -{
> -       return regulator_get_voltage(data->reg_vdd) / (MICRO / MILLI);
> -}
> -
>  static void ads1100_calc_scale_avail(struct ads1100_data *data)
>  {
> -       int millivolts = ads1100_get_vdd_millivolts(data);
> +       int millivolts = ads11x0_get_voltage_milivolts(data);
>         unsigned int i;
>
>         for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
> @@ -196,7 +269,7 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
>         switch (mask) {
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 *type = IIO_VAL_INT;
> -               *vals = ads1100_data_rate;
> +               *vals = data->data_rate;
>                 if (data->supports_data_rate)
>                         *length = ARRAY_SIZE(ads1100_data_rate);
>                 else
> @@ -233,12 +306,11 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_SCALE:
>                 /* full-scale is the supply voltage in millivolts */
> -               *val = ads1100_get_vdd_millivolts(data);
> +               *val = ads11x0_get_voltage_milivolts(data);
>                 *val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
>                 return IIO_VAL_FRACTIONAL_LOG2;
>         case IIO_CHAN_INFO_SAMP_FREQ:
> -               *val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
> -                                                  data->config)];
> +               *val = data->data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
>                 return IIO_VAL_INT;
>         default:
>                 return -EINVAL;
> @@ -280,8 +352,8 @@ static int ads1100_setup(struct ads1100_data *data)
>                 return ret;
>
>         ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
> -       if (ret < 0)
> -               return ret;
> +       if (ret < sizeof(buffer))
> +               return -1;

Same type promotion issue here. Additionally, I'd rather return -EIO than -1.

>
>         /* Config register returned in third byte, strip away the busy status */
>         data->config = buffer[2] & ~ADS1100_CFG_ST_BSY;
> @@ -292,9 +364,13 @@ static int ads1100_setup(struct ads1100_data *data)
>         return 0;
>  }
>
> -static void ads1100_reg_disable(void *reg)
> +static void ads1100_reg_disable(void *data)
>  {
> -       regulator_disable(reg);
> +       struct ads1100_data *ads1100_data = data;
> +
> +       /* Disable when not already disabled by the driver */
> +       if (!(ads1100_data->config & ADS1100_CFG_SC))
> +               regulator_disable(ads1100_data->reg_vdd);

Sashiko has something to say:

Could this leak the `vdd` regulator during device unbind due to the devres
execution order?
Devres executes registered actions in reverse order (LIFO). During unbind,
`ads1100_disable_continuous()` executes first and unconditionally sets
`ADS1100_CFG_SC`.
When `ads1100_reg_disable()` runs immediately after, the `ADS1100_CFG_SC` bit
is already set, causing this condition to fail and permanently skipping the
`regulator_disable()` call.

>  }
>
>  static void ads1100_disable_continuous(void *data)
> @@ -307,6 +383,7 @@ static int ads1100_probe(struct i2c_client *client)
>         struct iio_dev *indio_dev;
>         struct ads1100_data *data;
>         struct device *dev = &client->dev;
> +       const struct ads11x0_config *model;
>         int ret;
>
>         indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -334,10 +411,18 @@ static int ads1100_probe(struct i2c_client *client)
>                 return dev_err_probe(dev, ret,
>                                      "Failed to enable vdd regulator\n");
>
> -       ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data->reg_vdd);
> +       ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data);
>         if (ret)
>                 return ret;
>
> +       model = device_get_match_data(dev);
> +       if (!model)
> +               return dev_err_probe(dev, ret,
> +                               "Can't set device data\n");

Hmm, if device_get_match_data fails, ret will still be 0 per previous
devm_add_action_or_reset() call, therefore you're returning a "successful
error". Additionally, the error message isn't aligned with the parenthesis.
