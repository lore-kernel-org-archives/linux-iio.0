Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8A492538;
	Fri, 15 May 2026 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858470; cv=none; b=I5JMQygg8KKaO1ClF0Lq3JrIq6vtCXZRtduFiIkR9pHxLygJSXd3MwhsXuiHP2BYNFhrFVctD45XKgzkNCWkDSdgbiXO9fZJA15/j01BN/1ggKCfv+3hAwsNcCHyzmZWZAfzFlcdIYxsY6rEsiwSoMD5Sse0gUuKqDYe8buB7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858470; c=relaxed/simple;
	bh=jtm5qv33Z37L30Xcw3QM4YwpNOm2tw6PocRR0lUkmFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKaO9XIx+RcjOQbv3HjTZRkzIjPkmt5udNPLgh2YM0P54EAtNVSGplgwZagwePiWb7gIWK4JkUczhNDhq/hEnKk+0g4Vhu0P3mr+erMYejhmceNmRcMxeiZXA2esjSq/XOrNlRTwmSIC4dGcC6TF/7m55sXoSJ6AznH8RTtEqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/+Yji5l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/+Yji5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA40C2BCB7;
	Fri, 15 May 2026 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778858469;
	bh=jtm5qv33Z37L30Xcw3QM4YwpNOm2tw6PocRR0lUkmFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m/+Yji5lldVUU3D1jdDVwWNHZq9gcubWsSgBTFbV4LibMW9GSm5KKE3k0uzmOm8Ml
	 Nh7frk17G23G0bb+OMOr4gsuXUdaOcye3g9DzoaoWzugS5WW44Ga8AHswWvFtXUNSZ
	 YKCLo5VYPenWjGpy1ANcpuONKYCvEGf7a8YLg3HtvnEUoicJM1TkvJeeShrNk2+RD1
	 BepT3B44tpU3W2Ih0rhyqGEc1WOgSV6Z87CKjK0dcDazqRoqHfEAhlda66zmmtOvqR
	 Oof4KB/e8RGy3Gv37aamoXvYv+izepUUFFAZ5Je3ovYPMxeGlbk3FbJ6IMe+fopXPs
	 ygskcmmystDMQ==
Date: Fri, 15 May 2026 16:21:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Joshua Crofts
 <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v2 3/5] iio: light: tcs3472: use devm for resource
 management
Message-ID: <20260515162100.1dec8bb5@jic23-huawei>
In-Reply-To: <0de09560-6a79-46f0-8a63-3fb904a38231@gmail.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
	<20260512223215.25596-4-aldocontelk@gmail.com>
	<0de09560-6a79-46f0-8a63-3fb904a38231@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 22:29:55 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

> On 5/13/26 00:32, Aldo Conte wrote:
> > Convert the driver to use device-managed resource allocation:
> > - Add tcs3472_powerdown_action() and register it with
> >    devm_add_action_or_reset() to ensure the device is powered down on
> >    cleanup. Before this patch, the chip remained powered if probe
> >    failed after enabling it.
> > - Replace iio_triggered_buffer_setup() with
> >    devm_iio_triggered_buffer_setup().
> > - Replace request_threaded_irq() with devm_request_threaded_irq().
> > - Replace iio_device_register() with devm_iio_device_register().
> > - Remove tcs3472_remove() as all cleanup is now handled by devm.
> > 
> > Rewrite the read-modify-write pattern in tcs3472_powerdown() and
> > tcs3472_resume() so the new register value is computed first, written
> > to the chip, and committed to data->enable only on success.
> > 
> > Use a local 'dev = &client->dev' in tcs3472_probe() to keep the devm
> > calls compact.
> > 
> > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> > ---
> > v2:
> > (Suggested by Andy)
> > - Rewrote read-modify-write in tcs3472_powerdown() and tcs3472_resume()
> > - Use local 'struct device *dev = &client->dev' in probe.
> > - Dropped "Compiled with W=1" and test details from the commit message.
> > 
> >   drivers/iio/light/tcs3472.c | 107 +++++++++++++++++-------------------
> >   1 file changed, 51 insertions(+), 56 deletions(-)
> > 
> > diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> > index 4fd4fd74d0d6..7a6dc8360326 100644
> > --- a/drivers/iio/light/tcs3472.c
> > +++ b/drivers/iio/light/tcs3472.c
> > @@ -427,13 +427,38 @@ static const struct iio_info tcs3472_info = {
> >   	.attrs = &tcs3472_attribute_group,
> >   };
> >   
> > +static int tcs3472_powerdown(struct tcs3472_data *data)
> > +{
> > +	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
> > +	u8 value;
> > +	int ret;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	value = data->enable & ~enable_mask;
> > +
> > +	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, value);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->enable = value;
> > +
> > +	return 0;
> > +}
> > +
> > +static void tcs3472_powerdown_action(void *data)
> > +{
> > +	tcs3472_powerdown(data);
> > +}
> > +
> >   static int tcs3472_probe(struct i2c_client *client)
> >   {
> > +	struct device *dev = &client->dev;
> >   	struct tcs3472_data *data;
> >   	struct iio_dev *indio_dev;
> >   	int ret;
> >   
> > -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> >   	if (indio_dev == NULL)
> >   		return -ENOMEM;
> >   
> 
> Hi Jonathan,
> 
> In v3 I have a small style cleanup: replacing 'if (indio_dev == NULL)'
> with 'if (!indio_dev)' in tcs3472_probe(). This was suggested by
> Joshua Crofts in his v2 review.
> 
> What do you prefer it is a separate patch
> or folded into the devm conversion patch (which already modifies the
> context next to that line).
> 
> Either way works for me. Which do you prefer?

Separate patch.  However, don't rush. This version wants to sit on list
for a least a few more days!  For something as complex at this set
I'd suggest at least a week between first few versions.  Maybe
accelerate if you have a bunch of tags and there is just a little thing
needed.

Jonathan

> 
> Thanks,
> Aldo
> 
> ...
> 
> 

