Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC383955C8
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699772; cv=none; b=s1CewcEqjhn7VnWGJSVIaC8aVCN4oh75aInZF42mCw8T2hfLdeZ98l/ueJ/ViFx4p0WDWRYpvoKdHiEgvG3rduH9enq5o5o5qtZGNjt8ck4B6VGWW9NsVvDNHunGVc8PQXBI31E103kYCK3DEdRN2ncGyFWtzYdj0iZk1vok1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699772; c=relaxed/simple;
	bh=RQdw4iJpQz2PywfDIv0axE2Ik1d+XrvDVsfMkZCsYC4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:To:From; b=t0R4A9/aFKcU51gdkuGdOb51UmWvTaYF1TE2PHX5tCyoLUNInGt3T0y+KGHmT5OdFM9U8q8zTiPNrfJ+2cSu+oV11GZkkKqYgQVnBQZ353zwf2RSQHXpd9hZDpHr+LfzpmWZmTyDJrkt77YrDqe5CJk3ZNpv+gMJ9A4xnZwo6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlKg2nqt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlKg2nqt"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso8208408f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 02:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779699769; x=1780304569; darn=vger.kernel.org;
        h=from:to:subject:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9wFw69qSTOEpD3N1knpPNr5FrCWKKnBNKZed9pv7j5w=;
        b=nlKg2nqtGFyin5oWsNg4Q5fU9HBKK7tRq6NWozzuK/5j7jnBEMG5o/U4+LDDa+udQx
         nAcsq0qG1oF6rhtck2knNmTAoQus/NqNWsqV5U5KDRqxOLmCZ2CbJnHh8IHfSEwiTo4i
         4eySgWlTtE0Gc0Ti7M2vPlfd4DY/ao9c48IAWYUtZOD0QfTlMSFkvNktcCSG2kTsy6et
         49mZdTL1rz6JLQDLNjfyBBj2WOQYaLrWGs16QVZT9moHvNreNOhTduePd4HDb/6o8HHF
         9qmditAO+Fr91cFu3/H7eCwkUji9g52XKAo+KVWrlOkJDY2aZxSAccZ8CNQE+h7RYFKl
         sRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779699769; x=1780304569;
        h=from:to:subject:message-id:date:content-transfer-encoding
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wFw69qSTOEpD3N1knpPNr5FrCWKKnBNKZed9pv7j5w=;
        b=rG2H1tpzfy7ml0BTxTeug2rvGvdPpaxud6GL3yQ7vZDfGkigRY/0aPNcXkD6bnL2mB
         k1qfWzrFPQahm2wNcJHR0UCUOifJU+S56mLI3ndIHfHO80TjmoLmbPnxu5Hlef1/pVvp
         XSfX+hb0e2WIW44ObdTUPZxahIiJY4RzLR+SH1PoYGbf/xymND0NsN6nkCM46VavB1qB
         w9eVs/D4FLF0Y1FZd4/jKK9oSn5R41KXVCRYjgMLN7W+SOofokTOPP3O9Pe052uRxiCf
         XJ1eNqX4ymVaN+BeA6TQorjRhqT68zl788jysHwZUPl2PF2LIONSaztfDIpVp8Nhftom
         6efQ==
X-Gm-Message-State: AOJu0Yy0X3xoDdSH/oX2ufM9TPp26BQXsih4z1xByTQsT74YBFC7ozbt
	L46dg3fZvw8nFVIuD2JkQnfzXBoEIjxgVwkO4qJP9q4N7di4IB6S4xZwh+TE+Q==
X-Gm-Gg: Acq92OHS2j3jfXrLqq54yzI/YQV1q7Et/23r05N35DUcM+U5YZRUV8sazlo8x2ZGTIu
	TOcKLURN7NrdAUiQtytl+bnnusV4z0C+Iy6woLpA57btPtuG4yc68h24glVY4iYy7vzRbSQuitN
	gR4tk0GuDj9nIXbYYBJ8CJ1+bfJG97Z7uR1RUNX0In/Ru3OwF1VMSs3MU6L1hXPvdCTzoD5ToCa
	YSWhv8XHIvVIoi7Aub9G+W5XeeARVWkN3zgNn54Q2mJYZUWlE6GFiwB8BKQAIN1ihGabOT5mlIZ
	exweQKfJ309toyxv2RSDAb7HH2JSri0tFiaBs1Zgs0JeBFFYbQIKgyYHEmxk0I6ntnYdpOXDmIK
	sfiYZS283oyF/iWqYJuT2pwjeQ0Gm4qfuPZt1NQgTvymaOTAIKgAUFpmbJgrDpFyDZ/KZkyBmol
	WfsW/jmPBfRomvXzM9Y7pEtlVkwl+IZboWNsSN
X-Received: by 2002:a05:6000:4606:b0:45e:8727:be87 with SMTP id ffacd0b85a97d-45eb36aa72amr21905715f8f.15.1779699768670;
        Mon, 25 May 2026 02:02:48 -0700 (PDT)
Received: from localhost ([2001:4bb8:19a:6947:df80:1d3b:cdac:de73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6ccd211sm32407127f8f.10.2026.05.25.02.02.47
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 02:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 11:02:47 +0200
Message-Id: <DIRMWY4EUJYM.36YED21N67YBC@gmail.com>
Subject: Fwd: Re: [PATCH v3 4/4] iio: light: veml6031x00: add support for
 events and trigger
To: <linux-iio@vger.kernel.org>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09

Forwarded message from Javier Carrasco on Mon May 25, 2026 at 10:59 AM:
On Mon May 25, 2026 at 2:13 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Cache pollution of AF_TRIG causes unintended conversions and unn=
ecessary I2C reads.
> - [High] The trigger reference acquired via iio_trigger_get() is leaked o=
n probe error paths and driver unbind.
> - [High] PM runtime usage counter leaks if the driver unbinds while an ev=
ent is enabled.
> - [High] Sysfs read/write functions and trigger operations access hardwar=
e without acquiring a PM runtime reference.
> - [High] Out-of-bounds array write in veml6031x00_trig_handler when the t=
imestamp channel is enabled.
> - [Medium] Dead event sysfs attributes are exposed when no IRQ is present=
.
>
> Pre-existing issues:
> - [High] Unbalanced double-put of the runtime PM usage counter on driver =
unbind.
> - [High] The shutdown action accesses I2C registers after PM runtime has =
been disabled.
> --
>
> commit cbdd69d1454af4788d5d18a23d3fb6854c9981e9
> Author: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>
> iio: light: veml6031x00: add support for events and trigger
>
> The device provides a shared interrupt line for to notify events and
> data ready, which can be used as a trigger. The interrupt line is not a
> requirement for the device to work. Implement variants for the cases
> whether the interrupt line is provided or not.
>
>> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml603=
1x00.c
>> index 9968d4414dc96..c57aaa29abf30 100644
>> --- a/drivers/iio/light/veml6031x00.c
>> +++ b/drivers/iio/light/veml6031x00.c
>
> [ ... ]
>
>> @@ -136,6 +189,8 @@ static const struct iio_chan_spec veml6031x00_channe=
ls[] =3D {
>>  		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME),
>>  		.info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_INT_TIME),
>>  		.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
>> +		.event_spec =3D veml6031x00_event_spec,
>> +		.num_event_specs =3D ARRAY_SIZE(veml6031x00_event_spec),
>
> [Severity: Medium]
> Will this expose dead event sysfs attributes when no IRQ is present?
>
> When i2c->irq is 0, the driver registers veml6031x00_info_no_irq which la=
cks
> event callbacks. However, this channel array unconditionally defines
> event_spec and num_event_specs. The IIO core will parse these and expose
> event sysfs files. Reading or writing these files will fail with -EINVAL
> because the callbacks are NULL, which violates the sysfs API contract.
>
> [ ... ]
>

@Jonathan: is this how it really works? How can I then dynamically
define even_spec to account for it?

>> +static int veml6031x00_read_event_val(struct iio_dev *iio,
>> +				      const struct iio_chan_spec *chan,
>> +				      enum iio_event_type type,
>> +				      enum iio_event_direction dir,
>> +				      enum iio_event_info info,
>> +				      int *val, int *val2)
>> +{
>
> [Severity: High]
> Are PM runtime references needed here before accessing hardware?
>
> This function, as well as veml6031x00_write_event_val() and
> veml6031x00_set_trigger_state(), performs I2C accesses via regmap without
> first calling pm_runtime_resume_and_get(). If the device is
> runtime-suspended and its PM domain has powered it off, will these I2C
> accesses fail or time out?
>
> [ ... ]
>

As I said for [2/4], reading registers in shutdown mode is absolutely
fine.

>> +static int veml6031x00_write_event_config(struct iio_dev *iio,
>> +					  const struct iio_chan_spec *chan,
>> +					  enum iio_event_type type,
>> +					  enum iio_event_direction dir,
>> +					  bool state)
>> +{
>> +	struct veml6031x00_data *data =3D iio_priv(iio);
>> +	int ret;
>> +
>> +	guard(mutex)(&data->lock);
>> +
>> +	/* avoid multiple increments/decrements from one source */
>> +	if (state =3D=3D data->ev_en)
>> +		return 0;
>> +
>> +	if (state) {
>> +		ret =3D pm_runtime_resume_and_get(data->dev);
>
> [Severity: High]
> Could this leak the PM runtime usage counter if the driver unbinds?
>
> Enabling an event increments the PM runtime usage counter here. If the
> driver is unbound via sysfs while an event is enabled, the IIO core does
> not automatically disable the event. Since there is no unbind cleanup
> mechanism to release the pending PM reference when data->ev_en is true,
> does this keep the device powered on indefinitely?
>
> [ ... ]
>

@Jonathan: Does the IIO core let the event enabled? What is the
approach to clear it then?

>> +/* AF_TRIG is reset by hardware, but the rest of the fields are persist=
ent */
>> +static int veml6031x00_set_af_trig(struct veml6031x00_data *data, bool =
state)
>> +{
>> +	regcache_drop_region(data->regmap, VEML6031X00_REG_CONF0,
>> +			     VEML6031X00_REG_CONF0);
>> +
>> +	return regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
>> +				  VEML6031X00_CONF0_AF_TRIG,
>> +				  FIELD_PREP(VEML6031X00_CONF0_AF_TRIG, state));
>> +}
>
> [Severity: High]
> Can this cause unintentional active force conversions due to cache pollut=
ion?
>
> This sets the self-clearing AF_TRIG bit using regmap_update_bits().
> Because CONF0 is not marked as a volatile register, regmap_update_bits()
> writes AF_TRIG=3D1 and caches it. Any subsequent read-modify-write on CON=
F0
> (e.g., toggling the interrupt or changing integration time) will read the
> cached AF_TRIG=3D1 and write it back to hardware, unintentionally trigger=
ing
> an active force conversion and causing hardware state corruption.
>
> [ ... ]
>

I will define the CONF0 register as volatile to account for this.

>>  static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
>>  {
>>  	struct iio_poll_func *pf =3D p;
>>  	struct iio_dev *iio =3D pf->indio_dev;
>>  	struct veml6031x00_data *data =3D iio_priv(iio);
>>  	int ch, ret, i =3D 0;
>>  	struct {
>>  		__le16 chans[2];
>>  		aligned_s64 timestamp;
>>  	} scan =3D { };
>>
>>  	if (*iio->active_scan_mask =3D=3D (BIT(VEML6031X00_SCAN_ALS) |
>>  				       BIT(VEML6031X00_SCAN_IR))) {
>>  		ret =3D regmap_bulk_read(data->regmap,
>>  				       VEML6031X00_REG_ALS_L,
>>  				       &scan.chans, sizeof(scan.chans));
>>  		if (ret)
>>  			goto done;
>>  	} else {
>>  		iio_for_each_active_channel(iio, ch) {
>>  			ret =3D regmap_bulk_read(data->regmap,
>>  					       iio->channels[ch].address,
>>  					       &scan.chans[i++],
>
> [Severity: High]
> Does this loop cause an out-of-bounds array write if the timestamp
> channel is enabled?
>
> The iio_for_each_active_channel() loop does not exclude the soft timestam=
p
> channel. If the user enables ALS, IR, and TIMESTAMP channels, the loop
> iterates 3 times. However, the scan.chans array is declared as
> __le16 chans[2]. Processing the timestamp channel increments the index i
> to 2 and writes to scan.chans[2], causing an out-of-bounds memory write.
>
> Furthermore, because the timestamp channel's address is 0, this incorrect=
ly
> attempts a bogus I2C read from VEML6031X00_REG_CONF0.
>
> [ ... ]
>

Not sure if this is a real issue, and the address for channel 0 is not
CONF0 because it is defined in iio_chan_spec
veml6031x00_channels.address.

>> +static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev=
 *iio)
>> +{
>> +	struct veml6031x00_data *data =3D iio_priv(iio);
>> +	struct device *dev =3D data->dev;
>> +	int ret;
>> +
>> +	data->trig =3D devm_iio_trigger_alloc(dev, "%s-drdy%d", iio->name,
>> +					    iio_device_id(iio));
>> +	if (!data->trig)
>> +		return -ENOMEM;
>> +
>> +	data->trig->ops =3D &veml6031x00_trigger_ops;
>> +	iio_trigger_set_drvdata(data->trig, iio);
>> +
>> +	ret =3D devm_iio_trigger_register(dev, data->trig);
>> +	if (ret)
>> +		return ret;
>> +
>> +	iio->trig =3D iio_trigger_get(data->trig);
>
> [Severity: High]
> Is the trigger reference acquired here leaked on driver unbind?
>
> Calling iio_trigger_get() increments the trigger device's refcount and th=
e
> driver module's refcount. If the driver fails probe afterwards or is unbo=
und
> later, iio_trigger_put() is never called because there is no devres actio=
n
> registered for it and no custom remove callback. Does this permanently le=
ak
> the trigger device reference and prevent the module from being unloaded?
>
> [ ... ]
>

Same here. I believe that only industrialio-trigger.c makes use of
iio_trigger_put().

>> @@ -618,6 +1039,10 @@ static int veml6031x00_probe(struct i2c_client *i2=
c)
>
> [ ... ]
>
>>  	ret =3D devm_add_action_or_reset(dev, veml6031x00_als_shutdown_action,=
 data);
>
> [Severity: High]
> This is a pre-existing issue, but does this shutdown action access I2C
> registers after PM runtime has been disabled?
>
> This action is registered via devm_add_action_or_reset() before PM runtim=
e
> is enabled. On teardown, devm actions run in reverse, meaning PM runtime =
is
> disabled before the shutdown action runs. The shutdown action then attemp=
ts
> I2C writes while PM runtime is disabled. If the device was suspended, it
> cannot be resumed, potentially causing I2C transfer failures.
>
> [ ... ]
>
>>  	pm_runtime_put_autosuspend(dev);
>
> [Severity: High]
> This is a pre-existing issue, but is there an unbalanced double-put of th=
e
> runtime PM usage counter on driver unbind?
>
> The probe function registers a cleanup action to drop the PM reference vi=
a
> devm_pm_runtime_get_noresume(dev). However, this explicit put at the end
> of probe means the devm action will drop the reference a second time on
> unbind, causing a PM usage counter underflow that breaks the PM runtime
> state machine.

As I said for [2/4], there won't be any counter underflow that way.

Best,
Javier


