Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104A33EB18;
	Sat, 31 Jan 2026 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879700; cv=none; b=dOJbBbGJRWhuTbTueW8LtXZW+K/PigCBgc5DQqAEddCAGkvcGKI2aGqX3de1zu8MMhzNkgu88NIAEyAdUJnLzEH0BLZVdg/DzwR3oWwqzFr1bTN/fudkxipHGC7mUA+f+j2jYK9p3gHORKiyImkgdN1uT89iCH+cA2GaOC4VftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879700; c=relaxed/simple;
	bh=y7OF4KvdFH5r9o8tCXVaxQqwK+CwHxl8kUNPEiSXuR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncdO8RweVcxnSLZw9LqRNTaKZY3HFyYiVeSIMnohjxo1TTJ8nhCStl0YZg0Nh77+J/bODGuKp+bw0JZ4A1pUIMvnyD9DqjBQaky8WhOa2sxVprP5Ew7FrEhtlZfNE3/ItXLj+Cyza3vsePBi5Jo6s/SFFQi26Ef1FbBgm5n10DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pkt/8V5S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pkt/8V5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E93C4CEF1;
	Sat, 31 Jan 2026 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769879700;
	bh=y7OF4KvdFH5r9o8tCXVaxQqwK+CwHxl8kUNPEiSXuR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pkt/8V5S68fpzYRlGYgvBze5+G4MrFjV2/nIJLeqCm7WaVhWvzsMb3zH2pLnjyX3n
	 pIvz1ClW8F2BVi/uerzTQ3a32QlWAEShcXbzVHZg4tG4MnClZ5t5S+d8kpUwIGGrPM
	 bqb9zv4+WjV5Zj1wY3rmwTVJCiM/e75yVroB0T9Zu/JvUiqii5iWEsxhBBEOYtp1dk
	 sXnXgXeP7h/rhYK8MFCL8nW3l/nazBhoPJ6CtAMZVBx0h6YNfQXAiu3GbsUBBT8nm4
	 i9lUGDLe0u4UrlDSf56zPNq4dOSsudb+6s2S1wiXg2FK0Fs7kDKGEhmvYNuM8i4o9J
	 egm00Abp92fOQ==
Date: Sat, 31 Jan 2026 17:14:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: hsc030pa: Improve i2c_transfer return
 value handling
Message-ID: <20260131171452.669d95f2@jic23-huawei>
In-Reply-To: <aXyaCTZfJ8WC-rcq@sunspire.home.arpa>
References: <20260129181452.57628-1-antoniu.miclaus@analog.com>
	<aXyaCTZfJ8WC-rcq@sunspire.home.arpa>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 13:46:17 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hello Antoniu,
> 
> On Thu, Jan 29, 2026 at 08:14:52PM +0200, Antoniu Miclaus wrote:
> > The i2c_transfer() function returns the number of messages
> > successfully transferred. The function sends 1 message but checks
> > for ret == 2, which can never be true.
> > 
> > In practice this has no impact since the caller checks ret < 0,
> > and the erroneous return value of 1 is not treated as an error.
> > 
> > Improve the return value handling to properly distinguish between
> > I2C errors and unexpected transfer counts.  
> 
> thank you for the patch, much appreciated.
> 
> Tested-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied and pushed out as testing. This is 7.1 material now.

J
> 
> best regards,
> peter
> 
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > v2:
> >  - Changed subject from 'Fix' to 'Improve'
> >  - Clarified that the bug has no practical impact
> >  - Used explicit if/return pattern instead of ternary
> >  - Dropped Fixes tag
> > 
> >  drivers/iio/pressure/hsc030pa_i2c.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
> > index a34ef4653f34..3500bda03d75 100644
> > --- a/drivers/iio/pressure/hsc030pa_i2c.c
> > +++ b/drivers/iio/pressure/hsc030pa_i2c.c
> > @@ -34,8 +34,13 @@ static int hsc_i2c_recv(struct hsc_data *data)
> >  	msg.buf = data->buffer;
> >  
> >  	ret = i2c_transfer(client->adapter, &msg, 1);
> > +	if (ret < 0)
> > +		return ret;
> >  
> > -	return (ret == 2) ? 0 : ret;
> > +	if (ret != 1)
> > +		return -EIO;
> > +
> > +	return 0;
> >  }
> >  
> >  static int hsc_i2c_probe(struct i2c_client *client)
> > -- 
> > 2.43.0
> >   
> 

