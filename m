Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239BA2DCBFC
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776621048; cv=none; b=S9oR+h6Lw4A9+4qUCBmV99+Lkxz25qYVZhXKkApiSUM2zoCNS67r7d+m1rIAuPtxS0Q9mkz9aiES6aqemeDDnyX6G8Owht4L1kHvhu2d0MqplyIMXLQzOdykHdTSoIHboWbS1EONgirVoaUwhYcMvBiRli2G4xgGLQFqef5Ol9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776621048; c=relaxed/simple;
	bh=hmkXXp1ISw5In54C++6P2HwDNlRK7vs83vlnSGBXxCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRMPhLp8yHfdswO4nRlWP+/SQmofBzuZUQAJVvvWFNdZuXzaYGWGrPpsjqWftTt4dlkdXeyW02zJvu+zFZRjfD6m8p2Dk8HU04HwpwrTUbZBDSi6zqwjASjMa50OYn4lYzFwxRfO0k+MxxLJGEGubzc84RkG2YsaV6Acu1Gkkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyOid7OC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyOid7OC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC800C2BCAF;
	Sun, 19 Apr 2026 17:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776621047;
	bh=hmkXXp1ISw5In54C++6P2HwDNlRK7vs83vlnSGBXxCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VyOid7OCraKaGryPo/jbom/0upBvx8dYui5qf+IxEK1bC2W+kGbu0adaDFfHIN7nq
	 Ja2onTkMRH/xBPO6M2TR2LMN6CPub24ldxLGTfFTFw6A3vUJL3HHpi4WCJ0l2KMfSt
	 k+0/MN0cQO9v/2pzJYJSdjluFZgkf3CQ7L7fLMRVs5a7Q4RE+w2AzEzsccOoYW1eNw
	 8MAwSxTPX3Fr/sx24Jtr7wcG5beWV6PDVocVqokXejtIOgLaTAqVxKujMZ7vc0tHrz
	 8Mi2TZ4g7PeQJzWcj6TNV87HHDc9FH3H224qz1+RBccfD8A53k6bVvWN1PlY1rIoko
	 iNXG/4/Iju9eQ==
Date: Sun, 19 Apr 2026 18:50:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org,
 nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: chemical: bme680: remove unused
 BME680_NUM_CHANNELS macro
Message-ID: <20260419185041.705d2db2@jic23-huawei>
In-Reply-To: <710e2da4-2815-4137-84c4-1f148ec0a23f@baylibre.com>
References: <20260407090327.4987-1-nikhilgtr@gmail.com>
	<710e2da4-2815-4137-84c4-1f148ec0a23f@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Apr 2026 09:28:54 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/7/26 4:03 AM, Nikhil Gautam wrote:
> > The BME680_NUM_CHANNELS macro is not used anywhere in the driver.
> > Remove it to avoid keeping dead code and to improve readability.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> > ---
> >  drivers/iio/chemical/bme680.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> > index 7d86ed8b02e6..e10d3aaaca23 100644
> > --- a/drivers/iio/chemical/bme680.h
> > +++ b/drivers/iio/chemical/bme680.h
> > @@ -68,7 +68,6 @@
> >  /* Datasheet Section 1.1, Table 1 */
> >  #define BME680_STARTUP_TIME_US			2000
> >  
> > -#define BME680_NUM_CHANNELS			4
> >  #define BME680_NUM_BULK_READ_REGS		15
> >  
> >  /* Calibration Parameters */  
> 
> It looks like it was intended to be used in drivers/iio/chemical/bme680_core.c:

Agreed. I think probably better to use it than remove it?


> 
> struct bme680_data {
> 	struct regmap *regmap;
> 	struct bme680_calib bme680;
> 	struct mutex lock; /* Protect multiple serial R/W ops to device. */
> 	u8 oversampling_temp;
> 	u8 oversampling_press;
> 	u8 oversampling_humid;
> 	u8 preheat_curr_mA;
> 	u16 heater_dur;
> 	u16 heater_temp;
> 
> 	struct {
> 		s32 chan[4];
> 		aligned_s64 ts;
> 	} scan;
> 

