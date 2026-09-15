Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD71A3CB552;
	Tue, 15 Sep 2026 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789453288; cv=none; b=pN/b9UyPsqz++Gq+KmkOBaRavSF0a72oYh1/6QsEiCypkDFXPqvf24HS+bxUzT/VBgV3IURvhjcAhmFLHelZU0HsdUVbGXBX9IKi8WAxSaPwdf5ZFYIOug1BUXd/MFm6LNjCB3W6k/bFbdsxD9IKuVy+0OVKbf70rrOK22U6BGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789453288; c=relaxed/simple;
	bh=d3sDwbY/bSap2U/bPY3StbRKu+arE0nWuptk7IfLpD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQTbFvaE0Rn7T5MfcWqEmv1z3pe9aQ+emKbjwn35rvDLn8qYuI+UcFDtjZDSoQYcXm9Qiurx5GtwWMl3nlU1dINV8zENERLVUm/g8GmLB42a87GiEvWdSpqVjqNidgve0VeIctgClBalGENpiyW1UMsvwdliXtwHRjVnUmFsO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=MarFemOt; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="MarFemOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789453280; x=1789712480;
	bh=6ZGmV55ein3aniEmwL+HxLPHbKEpBRsMJ4RD0gO4vB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MarFemOtatQBJVAh3rx+83c9zN0K72yQQzZhL24bp0xkg2dgGYz3F9/UUhaeyhnMw
	 pPvnaMVTmKbeGawMRPZpyYv161F4YIi0WOY+N7btoW7Mgjxw0YT6+Kft09T/wEmywh
	 XMykCSJP+yTQ92DJycfJkKJBcIjabl1CLtnzrhYFtSSPT8fS1cDYW4YbWFNlRdq6s8
	 WiKkEMWpv+DqjPizkxmijTj7df5CzJ6OPHW+ngjZlfjQOFvNrFhom28Ua495e4vQnv
	 Sqj3yGLROmGFpl5ikS9z7r2pZDUKEi4OZWDSfDMufVWEA9BW3GK6YTfPGRdtwyn5D6
	 ZpoGTMr+RzfWw==
X-Pm-Submission-Id: 4hkX32308Vz1DF6l
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,  "Rob Herring"
 <robh@kernel.org>,  "Krzysztof Kozlowski" <krzk+dt@kernel.org>,  "Conor
 Dooley" <conor+dt@kernel.org>,  "Martin Kepplinger" <martink@posteo.de>,
  "Sean Nyekjaer" <sean@geanix.com>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Martin Kepplinger"
 <martin.kepplinger@theobroma-systems.com>,  "Christoph Muellner"
 <christoph.muellner@theobroma-systems.com>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 9/9] iio: accel: mma8452: Support interrupt sharing
In-Reply-To: <87y0d4pal0.fsf@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-9-c17407e22118@geanix.com>
	<_9NG2PCqwv-AxkrhQVOkPVIgvYD4-t2CFH5W5HVBmr35w9xmX9v9FIraB1OPE8Ssbd_pjQqM-bq3DEAtRl78Sg==@protonmail.internalid>
	<20260914002203.5ca07dd0@jic23-hlaptop>
	<lU80OLl5Xk_Bte8Klo69TR6a5JIitMP_N_IXZFIWkRKUmrV6NFHrMHxp1PUFoo8hb3OpKPo_4R2QWBYpfOLFJw==@protonmail.internalid>
	<87y0d4pal0.fsf@geanix.com>
Date: Tue, 15 Sep 2026 08:21:17 +0200
Message-ID: <87pkyfox0i.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Esben Haabendal" <esben@geanix.com> writes:

> "Jonathan Cameron" <jic23@kernel.org> writes:
>
>> On Mon, 07 Sep 2026 16:51:04 +0200
>> Esben Haabendal <esben@geanix.com> wrote:
>>
>>> Adding support for sharing interrupt line with other device requires the
>>> interrupt handler to handle runtime PM suspension properly, ignoring the
>>> irq if the device is suspended (maybe even off). And while at it, we use
>>> the PM reference to ensure we do not get suspended while processing an irq.
>>>
>>> In order to prevent the chip from raising irq while suspended (that is when
>>> using fixed regulator, where suspend just means setting the device in
>>> STANDBY mode), we disable all interrupt sources by clearing CTRL_REG4, and
>>> then restores the value again when resuming.
>>>
>>> With that in place, it is safe to add the IRQF_SHARED flag.
>>>
>>> Keep in mind that the device by default is using push-pull for the irq pin,
>>> which might require additional hardware design to allow interrupt sharing.
>>>
>>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>>> ---
>>>  drivers/iio/accel/mma8452.c | 67 +++++++++++++++++++++++++++++++++++++++------
>>>  1 file changed, 58 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>>> index fda29df5d109..e521dca37f76 100644
>>> --- a/drivers/iio/accel/mma8452.c
>>> +++ b/drivers/iio/accel/mma8452.c
>>> @@ -120,6 +120,7 @@
>>>   * @sleep_val:			time in ms to sleep while waiting for drdy
>>>   * @ctrl_reg1:			CTRL_REG1 register shadow value
>>>   * @data_cfg:			DATA_CFG register shadow value
>>> + * @ctrl_reg4:			CTRL_REG4 register value to restore on resume
>>>   * @open_drain:			true for irq pin in open-drain mode
>>>   */
>>>  struct mma8452_data {
>>> @@ -138,6 +139,7 @@ struct mma8452_data {
>>>  	int sleep_val;
>>>  	u8 ctrl_reg1;
>>>  	u8 data_cfg;
>>> +	u8 ctrl_reg4;
>>>  	bool open_drain;
>>>  };
>>>
>>> @@ -1083,15 +1085,21 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>>>  {
>>>  	struct iio_dev *indio_dev = p;
>>>  	struct mma8452_data *data = iio_priv(indio_dev);
>>> +	struct device *dev = &data->client->dev;
>>>  	irqreturn_t ret = IRQ_NONE;
>>> +	int pm_status;
>>>  	int src;
>>>
>>> +	pm_status = pm_runtime_get_if_active(dev);
>>
>> Sashiko raises the question of what happens if you actually get an error
>> return from this. You may be deliberately ignoring those, but if
>> so add a comment.
>
> Yes, sounds like a good idea.
>
>> The fun race around tear down is worth considering in particular (see
>> sashiko comment).
>
> I will look into that. Although very unlikely, it does sound like a real
> issue that *could* occur.
>
> Adding a boolean flag (remove_in_progress = true) to the mma8452_data
> struct, and set that in mma8452_remove() before disabling runtime pm
> seems like a KISS solution. Should we be returning IRQ_HANDLED or
> IRQ_NONE in that case?  There is no IRQ_MAYBE return value :D

Or maybe instead:

In mma8452_remove(), we switch the order of
pm_runtime_disable()/pm_runtime_set_suspended() with free_irq(), and
race condition will magically disappear without any further changes.

I will push a new version with this change.

>>> +	if (pm_status == 0)
>>> +		return IRQ_NONE; /* device is powered down */
>>
>>> @@ -1784,29 +1796,62 @@ static void mma8452_remove(struct i2c_client *client)
>>>  #ifdef CONFIG_PM
>>>  static int mma8452_runtime_suspend(struct device *dev)
>>>  {
>>> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>>> +	struct i2c_client *client = to_i2c_client(dev);
>>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>>  	struct mma8452_data *data = iio_priv(indio_dev);
>>>  	int ret;
>>>
>>> -	scoped_guard(mutex, &data->lock)
>>> -		ret = mma8452_standby(data);
>>> +	guard(mutex)(&data->lock);
>> Mixing guards...
>
> Yes, I know. Resolving that turned out to be a bit more painful than I
> thought. I do have that resolved in the next series I keep on talking
> about. But distilling that as a separate patch for adding to this series
> turned out to be impossible, as it relies on some of the other work,
> like refactoring of the ACTIVE/STANDBY state handling (synchronization),
> and most importantly, the switch to using regmap caching to properly
> handle restoring of register values on resume.
>
> I am therefore hoping that we can find some way to agree on things here,
> and then properly resolve it in the next series...
>
> For what it is worth, in this very specific case, the only guard used is
> first in the LIFO order, and will therefore be executed in exactly the
> right order on exit, as it will run after all the goto cleanup, just as
> the LIFO cleanup order requires.
>
> Obviously a fragile and undesirable way of doing error handling, but it
> will go away again in the next series where I will eliminate the goto
> error handling in mma8452_runtime_suspend().
>
>>> +
>>> +	ret = i2c_smbus_read_byte_data(client, MMA8452_CTRL_REG4);
>>>  	if (ret < 0) {
>>> -		dev_err(dev, "powering off device failed\n");
>>> +		dev_warn(dev, "backing up CTRL_REG4 failed\n");
>>>  		return -EAGAIN;
>>> +	} else
>>> +		data->ctrl_reg4 = ret;
>>> +
>>> +	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG4, 0);
>>> +	if (ret) {
>>> +		dev_warn(dev, "disabling interrupt sources (CTRL_REG4) failed\n");
>>> +		return -EAGAIN;
>>> +	}
>>> +
>>> +	ret = mma8452_standby(data);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "transition to STANDBY mode failed\n");
>>> +		ret = -EAGAIN;
>>> +		goto out_restore_ctrl_reg4;
>>
>> and goto is explicitly advised against in the docs in cleanup.h
>> You need to restructure the code to avoid that, potentially via
>> a helper function.
>
> I agree. See above.
>
>>>  	}
>>>
>>> +	/*
>>> +	 * Interrupt line should be deasserted now, so we just need ensure any
>>> +	 * mid-flight irq is completed (will return IRQ_NONE due to
>>> +	 * pm_status==0).
>>> +	 */
>>> +	if (client->irq)
>>> +		synchronize_irq(client->irq);
>>> +
>>>  	ret = regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
>>>  	if (ret) {
>>>  		dev_err(dev, "failed to disable regulators\n");
>>> -		return ret;
>>> +		goto out_active;
>>>  	}
>>>
>>>  	return 0;
>>> +
>>> +out_active:
>>> +	if (mma8452_active(data))
>>> +		dev_warn(dev, "failed to switch back to ACTIVE mode\n");
>>> +out_restore_ctrl_reg4:
>>> +	if (i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG4, data->ctrl_reg4))
>>> +		dev_warn(dev, "restoring CTRL_REG4 failed\n");
>>> +	return ret;
>>>  }
>>>
>>>  static int mma8452_runtime_resume(struct device *dev)
>>>  {
>>> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>>> +	struct i2c_client *client = to_i2c_client(dev);
>>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>>  	struct mma8452_data *data = iio_priv(indio_dev);
>>>  	int ret, sleep_val;
>>>
>>> @@ -1820,6 +1865,10 @@ static int mma8452_runtime_resume(struct device *dev)
>>>  	if (ret)
>>>  		goto runtime_resume_failed;
>>>
>>> +	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG4, data->ctrl_reg4);
>>> +	if (ret)
>>> +		goto runtime_resume_failed;
>>> +
>>>  	ret = mma8452_active(data);
>>>  	if (ret < 0)
>>>  		goto runtime_resume_failed;
>>>
