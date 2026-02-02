Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C672BE630;
	Mon,  2 Feb 2026 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064492; cv=none; b=GBJpWHIw8SAXdb9/uKITHjh1LImMKELfDtZjZ2RRGUAkcUWfCef7Em7pT8KyXVMoP4y+j+4YqP1/faSMQAvquJRGV2VD/LSRlsHxdBNJQSQH4zLrqesBEs7vRS0uz5NZLyzjXOrejyBjTO7Av8XX3KcsYcCumsUpLpyqGYH5EE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064492; c=relaxed/simple;
	bh=T8XBJOuMy+INL/R/vWNO2x1JxRrhKVF1wpOu92Zz/RI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGDCa4tILlrd33OgryKIpMIHCR65wexOdWppZeO9LZIN6px32cuhrIABNe0wsEPu1kwZDhESiT0Y/0CEuxXjjl/CqXqakv4q73Ms3galhNyOiv/SPNE1WJY6ZhVGC6unfwmqhLT7MaK3sSvSNi9JU9UjcetYgoqc7OaDUCxRjho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3ymQyX5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3ymQyX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DC3C116C6;
	Mon,  2 Feb 2026 20:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770064491;
	bh=T8XBJOuMy+INL/R/vWNO2x1JxRrhKVF1wpOu92Zz/RI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a3ymQyX5zVCelIcQa1bOOTfcIAjVran8QGeH7N81wjLz4TvSBCOKRoqbbG2qqhVGr
	 YDTueXyN/qK/EiuwQJ04QZ/Xg9YYy36U6BPwTmsS1zMlMn8IF8WJDWkeBprCtnODaC
	 Tnyo8xBUktLy+tkNdqOS8yI3M663aP6iMtVEZ9vFfOG7mKMmdnzkBCusxvkP1NdZMs
	 yXXgCd9kZQ0sdTZC6ySPXgOBMa3qlMm5l7ygfzM50OjOi+/d9qA0FcnojzDuTeS2rs
	 MqIllFba7Yx2DhJyCXKpLSU3n/Kw4eZ4VvLzRR6T2l8LhN+woPlDG4mcYTEN/W2mTT
	 U6xCW2Hk3/LHA==
Date: Mon, 2 Feb 2026 20:34:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Schmid <lukas.schmid@netcube.li>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RESEND [PATCH v1] iio: potentiometer: mcp4131: fix double
 application of wiper shift
Message-ID: <20260202203443.607eb65a@jic23-huawei>
In-Reply-To: <20260202202920.1d45fa8a@jic23-huawei>
References: <20260202201537.2194476-1-lukas.schmid@netcube.li>
	<20260202202920.1d45fa8a@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Feb 2026 20:29:20 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon,  2 Feb 2026 21:15:35 +0100
> Lukas Schmid <lukas.schmid@netcube.li> wrote:
> 
> > The MCP4131 wiper address is shifted twice when preparing the SPI
> > command in mcp4131_write_raw().
> > 
> > The address is already shifted when assigned to the local variable
> > "address", but is then shifted again when written to data->buf[0].
> > This results in an incorrect command being sent to the device and
> > breaks wiper writes to the second channel.
> > 
> > Remove the second shift and use the pre-shifted address directly
> > when composing the SPI transfer.
> > 
> > Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>  
> Hi Lukas,
> 
> Good find.  
> Needs a fixes tag though so that we can know how far to backport it.
> looks like this one goes all the way, so I'll just reply here and
> pick this up in a minute once my email reaches lore.
> 
> Fixes: 22d199a53910 ("iio: potentiometer: add driver for Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X")

I picked it up by hand.  A few things to note for next time.
If you do add RESEND then inside the [] so that the tooling maintainers
tend to use to pick stuff up (b4 / git am etc) doesn't included the
RESEND [PATCH v1] in the title of the commit.

Also, if you resend, please include a comment below the --- on why you
did so.

Now applied to my local tree as I'll be rebasing the fixes branch after
the release next weekend and am not planning to do a pull request before
then.

Thanks,

Jonathan

> 
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/potentiometer/mcp4131.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
> > index ad082827aad5..56c9111ef5e8 100644
> > --- a/drivers/iio/potentiometer/mcp4131.c
> > +++ b/drivers/iio/potentiometer/mcp4131.c
> > @@ -221,7 +221,7 @@ static int mcp4131_write_raw(struct iio_dev *indio_dev,
> >  
> >  	mutex_lock(&data->lock);
> >  
> > -	data->buf[0] = address << MCP4131_WIPER_SHIFT;
> > +	data->buf[0] = address;
> >  	data->buf[0] |= MCP4131_WRITE | (val >> 8);
> >  	data->buf[1] = val & 0xFF; /* 8 bits here */
> >    
> 

