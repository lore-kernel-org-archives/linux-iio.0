Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE893932E6;
	Thu, 17 Sep 2026 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626886; cv=none; b=u4yhcEF5AbzGp0e7mNk9ZPgzJZOUXQh5P44vGhRDOb0Q+XsbIogWh0VG9IyXKonlYTahorX2r/X5LOlxol/hvhQ4Ldy1yFZOnpypd/SGyBGB+CGwBQ8ihDWIve/0GD928ZvE7lVrRBpVF5BAtvaAF9Fu7U4MVxrngmRizomJrVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626886; c=relaxed/simple;
	bh=2/uFg4EjKbGHReWeWnTdshU9VW5fOVfHYiDnKJ+3ro8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVrpz+x1ZC7xDXxfAJx2fqL46c8MQ9kM2sFoGwKE5gu/VlEFuXFJlpIwDDhd+pCglgvEZcyMeEu6O1RRf3kH1CcTnHpB2tESeBLdDWyui9IA5GMpbR9e6nHPA85KqXjkMf27THeGv9BEePdLR420AW1xDSFPGn494IZI/34Z2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=jjKQEDXH; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="jjKQEDXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789626872; x=1789886072;
	bh=ugT0jmD7PYyfp4XG81Y3iv6whgBa6K0D7E7kXpwhpMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jjKQEDXHpyfAeSJn/+X7MIZzaBEsNvEUWXSaHdUZk6k4ItHgacDQ3WTso73U8/EGH
	 7pVkFSopu1yCU9dHq9yRqIItQ9vv5E5JkO/rpDyTp1IirA6BUXriXaPOdVJjO2LBem
	 nlwWmjNXegZu94YGxId4XMiGraR2WfA9MB8AtnWdqumhYawKG+n6e5oyTXQYEVCPrl
	 2TsDMwxTnLwS5NybLiu22c0QLTgIHGIPGAkkzxoG2wv8Rr3ZPGXXovVn/vuIEjvYAp
	 JNF1Ywu9EewSCxW6nSeUMY2WPH8t0aXy1mFVd0Ov0REkutS30zbXvvN2280n769akm
	 qPRyTTwT+5m5w==
X-Pm-Submission-Id: 4hlmFK3ghkz2ScD7
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
In-Reply-To: <20260917034721.0f4a8701@jic23-hlaptop>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-9-c17407e22118@geanix.com>
	<_9NG2PCqwv-AxkrhQVOkPVIgvYD4-t2CFH5W5HVBmr35w9xmX9v9FIraB1OPE8Ssbd_pjQqM-bq3DEAtRl78Sg==@protonmail.internalid>
	<20260914002203.5ca07dd0@jic23-hlaptop>
	<lU80OLl5Xk_Bte8Klo69TR6a5JIitMP_N_IXZFIWkRKUmrV6NFHrMHxp1PUFoo8hb3OpKPo_4R2QWBYpfOLFJw==@protonmail.internalid>
	<87y0d4pal0.fsf@geanix.com> <87pkyfox0i.fsf@geanix.com>
	<cbWGFGkr-0IRJ6KihI-uhTyO_d6SU8xex-XZtJkhLUVTbGiZn0uJDe0Cc5V1-1AKIwd9nU5nvIwgeB2d-rpOtA==@protonmail.internalid>
	<20260917034721.0f4a8701@jic23-hlaptop>
Date: Thu, 17 Sep 2026 08:34:28 +0200
Message-ID: <87wlsk75e3.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

> On Tue, 15 Sep 2026 08:21:17 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> "Esben Haabendal" <esben@geanix.com> writes:
>>
>> > "Jonathan Cameron" <jic23@kernel.org> writes:
>> >
>> >> On Mon, 07 Sep 2026 16:51:04 +0200
>> >> Esben Haabendal <esben@geanix.com> wrote:
>> >>
>> >>> Adding support for sharing interrupt line with other device requires the
>> >>> interrupt handler to handle runtime PM suspension properly, ignoring the
>> >>> irq if the device is suspended (maybe even off). And while at it, we use
>> >>> the PM reference to ensure we do not get suspended while processing an irq.
>> >>>
>> >>> In order to prevent the chip from raising irq while suspended (that is when
>> >>> using fixed regulator, where suspend just means setting the device in
>> >>> STANDBY mode), we disable all interrupt sources by clearing CTRL_REG4, and
>> >>> then restores the value again when resuming.
>> >>>
>> >>> With that in place, it is safe to add the IRQF_SHARED flag.
>> >>>
>> >>> Keep in mind that the device by default is using push-pull for the irq pin,
>> >>> which might require additional hardware design to allow interrupt sharing.
>> >>>
>> >>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> >>> ---
>> >>>  drivers/iio/accel/mma8452.c | 67 +++++++++++++++++++++++++++++++++++++++------
>> >>>  1 file changed, 58 insertions(+), 9 deletions(-)
>> >>>
>> >>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> >>> index fda29df5d109..e521dca37f76 100644
>> >>> --- a/drivers/iio/accel/mma8452.c
>> >>> +++ b/drivers/iio/accel/mma8452.c
>> >>> @@ -120,6 +120,7 @@
>> >>>   * @sleep_val:			time in ms to sleep while waiting for drdy
>> >>>   * @ctrl_reg1:			CTRL_REG1 register shadow value
>> >>>   * @data_cfg:			DATA_CFG register shadow value
>> >>> + * @ctrl_reg4:			CTRL_REG4 register value to restore on resume
>> >>>   * @open_drain:			true for irq pin in open-drain mode
>> >>>   */
>> >>>  struct mma8452_data {
>> >>> @@ -138,6 +139,7 @@ struct mma8452_data {
>> >>>  	int sleep_val;
>> >>>  	u8 ctrl_reg1;
>> >>>  	u8 data_cfg;
>> >>> +	u8 ctrl_reg4;
>> >>>  	bool open_drain;
>> >>>  };
>> >>>
>> >>> @@ -1083,15 +1085,21 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>> >>>  {
>> >>>  	struct iio_dev *indio_dev = p;
>> >>>  	struct mma8452_data *data = iio_priv(indio_dev);
>> >>> +	struct device *dev = &data->client->dev;
>> >>>  	irqreturn_t ret = IRQ_NONE;
>> >>> +	int pm_status;
>> >>>  	int src;
>> >>>
>> >>> +	pm_status = pm_runtime_get_if_active(dev);
>> >>
>> >> Sashiko raises the question of what happens if you actually get an error
>> >> return from this. You may be deliberately ignoring those, but if
>> >> so add a comment.
>> >
>> > Yes, sounds like a good idea.
>> >
>> >> The fun race around tear down is worth considering in particular (see
>> >> sashiko comment).
>> >
>> > I will look into that. Although very unlikely, it does sound like a real
>> > issue that *could* occur.
>> >
>> > Adding a boolean flag (remove_in_progress = true) to the mma8452_data
>> > struct, and set that in mma8452_remove() before disabling runtime pm
>> > seems like a KISS solution. Should we be returning IRQ_HANDLED or
>> > IRQ_NONE in that case?  There is no IRQ_MAYBE return value :D
>>
>> Or maybe instead:
>>
>> In mma8452_remove(), we switch the order of
>> pm_runtime_disable()/pm_runtime_set_suspended() with free_irq(), and
>> race condition will magically disappear without any further changes.
>>
>> I will push a new version with this change.
>
> I'm not keen if that means we are disabling in a different order to setup.
> Now if you can flip setup as well it is probably fine.

Yes, we should be using same order in setup. I will do that.

Can I keep it in this patch, or do you want this to be split into a
separate patch (together with change to mma8452_remove())?

AFAICS, the changes doesn't fix anything without the changes in
mma8452_interrupt() in this patch, so you could argue that it doesn't
make sense as a separate change.

/Esben
