Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04AB139D;
	Sun, 15 Feb 2026 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771183884; cv=none; b=myrfCyjnxbI45vFbbx+It5bfFBFqVqIukDwiRM5iIKVtWKOEbt+ETY7BN4hWx24JtMWtA1qqp7Mpz2PTkOkYMq30RsnpSrPSEh/y/sni1yta6n5FKZrtpFNXLCiKP+jomLYkYtf+vyun9+TgAJAIUyaDUY8mibyK6f9Ra69kCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771183884; c=relaxed/simple;
	bh=YUFwljSclpXuAJwzKYldElUKW0OXoIZkIj60REl5nEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHnmNFfsDnA8TriscJF6vtUSGNi925PqKHRxtPKAH80U5bWdFElu2hL7aQF15z1EJChVYMXrSB18JwCeYd7RPI27qdoMoS7eiS9TDJa5UNbVyZZUo9LqBCyjb2sEpsnsL0UhJMua0Si1iliJJ0bSLinqc/Q2fOZqEozjnQNxM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfwBDkh3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfwBDkh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9828BC4CEF7;
	Sun, 15 Feb 2026 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771183884;
	bh=YUFwljSclpXuAJwzKYldElUKW0OXoIZkIj60REl5nEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KfwBDkh33NxWapDdKV5jRXKs0i9CATLjd6mc+uNnVkxAO4RCqa0tRoKRCHosZqVbW
	 TKyF+e3idflRPVdjejg9AI82vmPtpCi/lrTVIfQabXtRhajIl3rzC5ZfVPzmGFhr9k
	 yE7Pj4Xru6K7BH7+CV9Aa81eHErGqOQtLYlWFtwoV1eq7QbcJPAfnZwBa6I8RTP36m
	 YjKn/HZ/SVVbkSHdk5kC7C8cXke0RIXX/dvkugFEHOAuDU5592GX3ElwVUQlEquokK
	 Z/w9LvHcR48wJ0ZJy62cq9aBEmSbz/x8KubRgIBKMTy1b4i6H5ls7MPAKxR269k7tf
	 /t4l1m2ut80lA==
Date: Sun, 15 Feb 2026 19:31:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com, krzk+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 phone-devel@vger.kernel.org, pmeerw@pmeerw.net, robh@kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 2/2] iio: light: vcnl4000: add support for Capella
 CM36686 and CM36672P
Message-ID: <20260215193114.2a1010a8@jic23-huawei>
In-Reply-To: <20260215172856.34702-1-xerikasxx@gmail.com>
References: <20260214180919.72389701@jic23-huawei>
	<20260215172856.34702-1-xerikasxx@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Feb 2026 19:28:56 +0200
Erikas Bitovtas <xerikasxx@gmail.com> wrote:

> On 2/14/26 8:09 PM, Jonathan Cameron wrote:
> >> ---
> >>  drivers/iio/light/vcnl4000.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 40 insertions(+)
> >>
> >> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> >> index a36c23813679..1f8f4e4586f4 100644
> >> --- a/drivers/iio/light/vcnl4000.c
> >> +++ b/drivers/iio/light/vcnl4000.c
> >> @@ -185,6 +185,7 @@ static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
> >>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
> >>  
> >>  enum vcnl4000_device_ids {
> >> +	CM36672P,
> >>  	VCNL4000,
> >>  	VCNL4010,
> >>  	VCNL4040,
> >> @@ -235,6 +236,8 @@ struct vcnl4000_chip_spec {
> >>  };
> >>  
> >>  static const struct i2c_device_id vcnl4000_id[] = {
> >> +	{ "cm36672p", CM36672P },
> >> +	{ "cm36686", VCNL4040 },
> >>  	{ "vcnl4000", VCNL4000 },
> >>  	{ "vcnl4010", VCNL4010 },
> >>  	{ "vcnl4020", VCNL4010 },
> >> @@ -1842,6 +1845,22 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
> >>  	}
> >>  };  
> > 
> > ...
> >   
> >>  	[VCNL4000] = {
> >>  		.prod = "VCNL4000",
> >>  		.init = vcnl4000_init,
> >> @@ -2033,6 +2065,14 @@ static int vcnl4000_probe(struct i2c_client *client)
> >>  }
> >>  
> >>  static const struct of_device_id vcnl_4000_of_match[] = {
> >> +	{
> >> +		.compatible = "capella,cm36672p",
> >> +		.data = (void *)CM36672P,
> >> +	},
> >> +	{
> >> +		.compatible = "capella,cm36686",
> >> +		.data = (void *)VCNL4040,  
> > 
> > Is this necessary? I 'think' if you drop it we'll match instead
> > on the vcnl4040 fallback and then the access to the data will be
> > through the stripped name only bit of the compatible (first entry, not
> > the fallback so cm36686 in this case). So you do need the cm36686
> > entry in the i2c_device_id table above. Probably better to keep
> > this here to avoid having to reason this out - but perhaps a
> > comment to that affect would be useful (assuming you verify my
> > reasoning).
> >  
> After I removed the entry for "capella,cm36686", I received the "Unable
> to handle kernel NULL pointer dereference" error in dmesg. And at least
> stk3310 driver includes a compatible entry both for the device (stk3013)
> and for the fallback (stk3310). So my assumption is that this entry is
> needed.
> I could include a comment explaining that cm36686 is fully compatible
> with vcnl4040, however, if that is necessary.

Thanks for checking.

What did you get as the backtrace?  I'm hoping it'll explain what I'm
misunderstanding!  The hacks around using the wrong table for compatible
matches have tripped me up before.

Jonathan

> > As Andy suggested moving away from enum values an towards
> > direct pointers to the chip_info structures + drop the
> > i2c_client_get_device_id() in favour of i2c_get_match_data() which
> > uses the right firmware entry to get the data in all cases is the
> > right long term solution and avoids an association being necessary
> > between the two tables.
> > 
> > Jonathan
> > 
> > 
> > 
> >   
> >> +	},
> >>  	{
> >>  		.compatible = "vishay,vcnl4000",
> >>  		.data = (void *)VCNL4000,
> >>  
> >   
> 

