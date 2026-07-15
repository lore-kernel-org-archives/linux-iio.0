Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782194483B1;
	Wed, 15 Jul 2026 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114971; cv=none; b=SbqgI9IMNwdL16v2PJhA+kxtv/lKiOIpZwPLmRIXczTNU+2leZKitbc06odwwwI1aXl0qvKhQS7hnLtoVyak0yTAR+QbSlPNJxHaepFhK0bt73MKbtgPpTrzxIUHk15JfDmoXfPA6b0JnpFKPehxd5en9zLr+SWMBJ+XsNPCk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114971; c=relaxed/simple;
	bh=oU6TWkADlMZXoeCAqNCi5RjMi84G1RFuFOF5OYtth8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YNGn7dai3VM1qpdR9ghbCX9cG3wETNhGz2KisXmk5BbpG24iDrc+koBDg1Lqsm7682p+K0MAoV+4DvAFKTqvTwhrw061ZsI5C117eSQNxrkAnvqGQSqfPuQrdjxZGG0XsBJJXVd+1KsJhd2YloypZeNN+TqkZz/z+8U2q7E5Ce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ddaqPR/o; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ddaqPR/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784114962; x=1784374162;
	bh=AG9eoWJ4RbxSlvNAL5Is060sMOmCsPqGqO2bDLThoic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ddaqPR/oG0dUXZ4vlq2AlEF3Iomvuc5GxeRX0nG7oaSHvnRc/XqISkKDhBLyXpWOM
	 p/AbHD6QG2mdQiThAOYOjwZRz+ALIVNQkqdpDXnLRobodIg3iRfdo8g+WbJrBWZhKC
	 tLLV3HX7mq5GXjrIIyYP8ciMSRHH/6/msBCt+/vhPbOkNRhATj73OxjgII9EAdzKf6
	 A5mwZFBqDLgZPUGWXjyumGYPGDxIiKkhyZalT56mA0lTFxkCCSOIW7Pr2Yfky++z+9
	 +bqzgHCGoH5mSdSOj2sYIZm9bQ7D6yVaxQURlzp0jMYgzcwIQFlTVcW2aq4HiFj9Jm
	 Qn1i0Zwxs5K7g==
X-Pm-Submission-Id: 4h0Yq25w8cz2Scmy
From: Esben Haabendal <esben@geanix.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
In-Reply-To: <20260715104542.0000433d@gmail.com> (Joshua Crofts's message of
	"Wed, 15 Jul 2026 10:45:42 +0200")
References: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
	<20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com>
	<PLKuTyVcES-o-CEsU7WA3Ir7-phI9WLM9PJ5UErJeahWgus8heVF4GPky0SC-EpaHLv54lZya37ivhub3W9kNQ==@protonmail.internalid>
	<20260715104542.0000433d@gmail.com>
Date: Wed, 15 Jul 2026 13:29:17 +0200
Message-ID: <87pl0oo5iq.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Joshua Crofts" <joshua.crofts1@gmail.com> writes:

> On Wed, 15 Jul 2026 10:07:39 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> When sharing interrupt line with other chips, the interrupt pin most
>> likely needs to be configured in open-drain mode instead of push-pull.
>> If this is needed, you must add drive-open-drain property to the
>> device-tree.
>
> Why are you mentioning the device tree in the commit message? Just keep
> the first sentence + a short description of what you
> added/changed/removed.

Sure. Will do that for v2.

>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/iio/accel/mma8452.c | 29 ++++++++++++++++++++++++++++-
>>  1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 7d683686dd9d..a20c02ce0b9c 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -81,6 +81,8 @@
>>  #define  MMA8452_CTRL_REG2_RST			BIT(6)
>>  #define  MMA8452_CTRL_REG2_MODS_SHIFT		3
>>  #define  MMA8452_CTRL_REG2_MODS_MASK		0x1b
>> +#define MMA8452_CTRL_REG3			0x2c
>> +#define  MMA8452_CTRL_REG3_PP_OD		BIT(0)
>
> I know that the defines are completely incorrectly aligned, but please
> ensure that at least all the defines in this block are aligned.
>
> Also, consider sending a patch which aligns all the other defines.

How are they incorrectly aligned?
The all look perfectly fine here (visual tabs space set to 8).
Should I convert all the tabs used for alignment to spaces?

AFAICS, I have added the defines with same alignment as the other
defines in that block. I believe the misalignment is only a visual
artifact caused by the diff format.

>>  #define MMA8452_CTRL_REG4			0x2d
>>  #define MMA8452_CTRL_REG5			0x2e
>>  #define MMA8452_OFF_X				0x2f
>> @@ -108,6 +110,7 @@ struct mma8452_data {
>>  	struct iio_mount_matrix orientation;
>>  	u8 ctrl_reg1;
>>  	u8 data_cfg;
>> +	bool open_drain;
>
> Hmm, i checked pahole and it says there is a 1 byte hole, maybe try some more
> reordering to pack it?

On aarch64 it was this:

struct mma8452_data {
        struct i2c_client *        client;               /*     0     8 */
        struct mutex               lock __attribute__((__aligned__(8))); /*     8    24 */
        struct iio_mount_matrix    orientation;          /*    32    72 */
        /* --- cacheline 1 boundary (64 bytes) was 40 bytes ago --- */
        u8                         ctrl_reg1;            /*   104     1 */
        u8                         data_cfg;             /*   105     1 */
        bool                       open_drain;           /*   106     1 */

        /* XXX 5 bytes hole, try to pack */

        const struct mma_chip_info  * chip_info;         /*   112     8 */
        int                        sleep_val;            /*   120     4 */

        /* XXX 4 bytes hole, try to pack */

        /* --- cacheline 2 boundary (128 bytes) --- */
        struct regulator *         vdd_reg;              /*   128     8 */
        struct regulator *         vddio_reg;            /*   136     8 */
        struct {
                __be16             channels[3];          /*   144     6 */

                /* XXX 2 bytes hole, try to pack */

                __s64              ts __attribute__((__aligned__(8))); /*   152     8 */
        } __attribute__((__aligned__(8))) buffer __attribute__((__aligned__(8)));        /*   144    16 */

        /* XXX last struct has 1 hole */

        /* size: 160, cachelines: 3, members: 11 */
        /* sum members: 151, holes: 2, sum holes: 9 */
        /* member types with holes: 1, total: 1 */
        /* forced alignments: 2 */
        /* last cacheline: 32 bytes */
} __attribute__((__aligned__(8)));

After reordering member fields, I get this:

struct mma8452_data {
        struct i2c_client *        client;               /*     0     8 */
        struct mutex               lock __attribute__((__aligned__(8))); /*     8    24 */
        struct iio_mount_matrix    orientation;          /*    32    72 */
        /* --- cacheline 1 boundary (64 bytes) was 40 bytes ago --- */
        const struct mma_chip_info  * chip_info;         /*   104     8 */
        struct regulator *         vdd_reg;              /*   112     8 */
        struct regulator *         vddio_reg;            /*   120     8 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        struct {
                __be16             channels[3];          /*   128     6 */

                /* XXX 2 bytes hole, try to pack */

                __s64              ts __attribute__((__aligned__(8))); /*   136     8 */
        } __attribute__((__aligned__(8))) buffer __attribute__((__aligned__(8)));        /*   128    16 */

        /* XXX last struct has 1 hole */

        int                        sleep_val;            /*   144     4 */
        u8                         ctrl_reg1;            /*   148     1 */
        u8                         data_cfg;             /*   149     1 */
        bool                       open_drain;           /*   150     1 */

        /* size: 152, cachelines: 3, members: 11 */
        /* padding: 1 */
        /* member types with holes: 1, total: 1 */
        /* forced alignments: 2 */
        /* last cacheline: 24 bytes */
} __attribute__((__aligned__(8)));

>>  	const struct mma_chip_info *chip_info;
>>  	int sleep_val;
>>  	struct regulator *vdd_reg;
>> @@ -646,6 +649,22 @@ static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
>>  	return mma8452_change_config(data, MMA8452_CTRL_REG2, reg);
>>  }
>>
>> +static int mma8452_set_interrupt_pin_mode(struct mma8452_data *data)
>> +{
>> +	int reg;
>> +
>> +	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG3);
>> +	if (reg < 0)
>> +		return reg;
>> +
>> +	if (data->open_drain)
>> +		reg |= MMA8452_CTRL_REG3_PP_OD;
>> +	else
>> +		reg &= ~MMA8452_CTRL_REG3_PP_OD;
>> +
>> +	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG3, reg);
>> +}
>> +
>>  /* returns >0 if in freefall mode, 0 if not or <0 if an error occurred */
>>  static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
>>  {
>> @@ -1666,6 +1685,9 @@ static int mma8452_probe(struct i2c_client *client)
>>  			goto disable_regulators;
>>  	}
>>
>> +	data->open_drain = device_property_read_bool(&client->dev, "drive-open-drain");
>> +	mma8452_set_interrupt_pin_mode(data);
>
> You're not checking the return value here.

Sorry, I will propagate the error code up.

>>  	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
>>  			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
>>
>> @@ -1683,7 +1705,8 @@ static int mma8452_probe(struct i2c_client *client)
>>
>>  	if (client->irq) {
>>  		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
>> -					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
>> +					   data->open_drain ? IRQF_SHARED : 0,
>
> Sashiko raises a pretty fun issue: the statement
>
> IRQF_TRIGGER_LOW | IRQF_ONESHOT | data->open_drain ? IRQF_SHARED : 0
>
> is actually evaluated as
>
> (IRQF_TRIGGER_LOW | IRQF_ONESHOT | data->open_drain) ? IRQF_SHARED : 0
>
> Bitwise OR precedes the ternary operator.
>
> You should wrap the data->open_drain ternary in parenthesis.

Yep. That was a nice catch indeed. Fixed.

>>  					   client->name, indio_dev);
>>  		if (ret)
>>  			goto buffer_cleanup;
>> @@ -1800,6 +1823,10 @@ static int mma8452_runtime_resume(struct device *dev)
>>  		return ret;
>>  	}
>>
>> +	ret = mma8452_set_interrupt_pin_mode(data);
>> +	if (ret < 0)
>> +		goto runtime_resume_failed;
>
> You can just have if (ret), as only 0 is successful.

Will do.

>> +
>>  	ret = mma8452_active(data);
>>  	if (ret < 0)
>>  		goto runtime_resume_failed;
