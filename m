Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986C2E1C7C;
	Wed, 18 Feb 2026 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443132; cv=none; b=ucpCeOOcJKHCkZiOeYpEa7BXDKSnugWh4ZDlXr6jVqkG4AoQ5UNkCjlJgJy1RBrH9IyhEmAla/s2yOP/4jY34qgO5Q+RRpCAnBspVqKuQsfEdp1+UVeDRRtEOYLGk+n6e1MjCeejqRcpDd1JDgDrr0NU8uNyREbcZq4Fqqe3zHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443132; c=relaxed/simple;
	bh=VorzV0gWr0O6AA2ImGqp/U+3EMA/7VoEq4X1IOkrX6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMcEeCn5+wx2b9NTz8waIqVbkQ0gfwcUo8KnpWRd2OAPb2k241cA1JxP77H9SvWjgFXrVTwzc1iD4NigT6rcIRUkqDzGRjTP5tJIcgMeoHX8SE0w/UF+7v+QmsNf94fTLY+fVnrTq2aurYgX8u/N39OLoWwrvONJ64B8b1o0sUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLtnW0dL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLtnW0dL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B96DC116D0;
	Wed, 18 Feb 2026 19:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771443132;
	bh=VorzV0gWr0O6AA2ImGqp/U+3EMA/7VoEq4X1IOkrX6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pLtnW0dLufISY0raQ1oP7SquwZMCZr1as+DhzKHCxcEAVpUfFNyO1k+X1ldSchpCv
	 Kizfyc1NnlcXlw53Ez5i4viDxMBkBZP7/2dmWeXynjQ9dGD0jzCAX8FzZGhs//TbGV
	 KNppP+RHEOBvFUjjLBn67XrbgkC5cCkrC5zM0v4mq8IDVRzBRR03FOszkMzoBs8kls
	 KxoQBnj6UNmsKa2WRt8H4y61NT3fJKnGva2I3fAO+c6X7KIsl/DU16n3VcLGGABNqb
	 oeUMDFx/hFxaZ8PjPewl9uOGEVfkeJO0snDWnNR/NGsTJJG2A1bLfkPL2HFMFOdFAJ
	 VtK6LNCcbW8AA==
Date: Wed, 18 Feb 2026 19:32:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com, krzk+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 phone-devel@vger.kernel.org, pmeerw@pmeerw.net, robh@kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 2/2] iio: light: vcnl4000: add support for Capella
 CM36686 and CM36672P
Message-ID: <20260218193201.5117479b@jic23-huawei>
In-Reply-To: <ceb597ed-3380-4952-b159-36f3862bf2c2@gmail.com>
References: <20260215193114.2a1010a8@jic23-huawei>
	<20260215200628.53841-1-xerikasxx@gmail.com>
	<20260215215519.23126ef3@jic23-huawei>
	<ceb597ed-3380-4952-b159-36f3862bf2c2@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 10:21:23 +0200
Erikas Bitovtas <xerikasxx@gmail.com> wrote:

> On 2/15/26 11:55 PM, Jonathan Cameron wrote:
> > On Sun, 15 Feb 2026 22:06:28 +0200
> > Erikas Bitovtas <xerikasxx@gmail.com> wrote:
> >   
> >> On 2/15/26 9:31 PM, Jonathan Cameron wrote:  
> >>> On Sun, 15 Feb 2026 19:28:56 +0200
> >>> Erikas Bitovtas <xerikasxx@gmail.com> wrote:
> >>>     
> >>>> On 2/14/26 8:09 PM, Jonathan Cameron wrote:    
> >>>>>> ---
> >>>>>>  drivers/iio/light/vcnl4000.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >>>>>>  1 file changed, 40 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> >>>>>> index a36c23813679..1f8f4e4586f4 100644
> >>>>>> --- a/drivers/iio/light/vcnl4000.c
> >>>>>> +++ b/drivers/iio/light/vcnl4000.c
> >>>>>> @@ -185,6 +185,7 @@ static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
> >>>>>>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
> >>>>>>  
> >>>>>>  enum vcnl4000_device_ids {
> >>>>>> +	CM36672P,
> >>>>>>  	VCNL4000,
> >>>>>>  	VCNL4010,
> >>>>>>  	VCNL4040,
> >>>>>> @@ -235,6 +236,8 @@ struct vcnl4000_chip_spec {
> >>>>>>  };
> >>>>>>  
> >>>>>>  static const struct i2c_device_id vcnl4000_id[] = {
> >>>>>> +	{ "cm36672p", CM36672P },
> >>>>>> +	{ "cm36686", VCNL4040 },
> >>>>>>  	{ "vcnl4000", VCNL4000 },
> >>>>>>  	{ "vcnl4010", VCNL4010 },
> >>>>>>  	{ "vcnl4020", VCNL4010 },
> >>>>>> @@ -1842,6 +1845,22 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
> >>>>>>  	}
> >>>>>>  };      
> >>>>>
> >>>>> ...
> >>>>>       
> >>>>>>  	[VCNL4000] = {
> >>>>>>  		.prod = "VCNL4000",
> >>>>>>  		.init = vcnl4000_init,
> >>>>>> @@ -2033,6 +2065,14 @@ static int vcnl4000_probe(struct i2c_client *client)
> >>>>>>  }
> >>>>>>  
> >>>>>>  static const struct of_device_id vcnl_4000_of_match[] = {
> >>>>>> +	{
> >>>>>> +		.compatible = "capella,cm36672p",
> >>>>>> +		.data = (void *)CM36672P,
> >>>>>> +	},
> >>>>>> +	{
> >>>>>> +		.compatible = "capella,cm36686",
> >>>>>> +		.data = (void *)VCNL4040,      
> >>>>>
> >>>>> Is this necessary? I 'think' if you drop it we'll match instead
> >>>>> on the vcnl4040 fallback and then the access to the data will be
> >>>>> through the stripped name only bit of the compatible (first entry, not
> >>>>> the fallback so cm36686 in this case). So you do need the cm36686
> >>>>> entry in the i2c_device_id table above. Probably better to keep
> >>>>> this here to avoid having to reason this out - but perhaps a
> >>>>> comment to that affect would be useful (assuming you verify my
> >>>>> reasoning).
> >>>>>      
> >>>> After I removed the entry for "capella,cm36686", I received the "Unable
> >>>> to handle kernel NULL pointer dereference" error in dmesg. And at least
> >>>> stk3310 driver includes a compatible entry both for the device (stk3013)
> >>>> and for the fallback (stk3310). So my assumption is that this entry is
> >>>> needed.
> >>>> I could include a comment explaining that cm36686 is fully compatible
> >>>> with vcnl4040, however, if that is necessary.    
> >>>
> >>> Thanks for checking.
> >>>
> >>> What did you get as the backtrace?  I'm hoping it'll explain what I'm
> >>> misunderstanding!  The hacks around using the wrong table for compatible
> >>> matches have tripped me up before.
> >>>
> >>> Jonathan
> >>>     
> >>
> >> I am attaching a link to the dmesg. There were quite a lot of lines in
> >> the stack trace and I am not sure what is the right way to post logs in
> >> the mailing list.
> >>
> >> https://pastebin.com/QgeTdNEP  
> > 
> > Thanks. only relevant bit is probably:
> > 
> > [   15.566076]  vcnl4000_probe+0x54/0x288 [vcnl4000] (P)
> > [   15.566102]  i2c_device_probe+0x2b0/0x358
> > [   15.566121]  really_probe+0x154/0x448
> > 
> > My guess is my understanding of i2c_client_get_device_id() is wrong and that
> > is returning NULL.  That can only happen if client->name is not a match for
> > anything the i2_device_id table.  If you have a chance, can you dump
> > what client->name is in this case? I thought it ended up as
> > cm36686 (stripped first entry in compatible) but seems I'm probably wrong on
> > that :(
> > 
> > The path I thought worked was via info->type (which gets copied to client->name)
> > set via of_alias_from_compatible() here.
> > https://elixir.bootlin.com/linux/v6.19-rc4/source/drivers/i2c/i2c-core-of.c#L30
> > Which should just return the first compatible without that vendor prefix.
> > 
> > Meh, this doesn't really matter anyway as once we refactor to actually use
> > the data in the of_device_id table, we will need the entry and in the meantime
> > it's sort of documentation.
> > 
> > J
> >   
> 
> Apparently I just had commented out the i2c_device_id entry for cm36686
> as well, when I had to comment out only of_device_id entry. After adding
> i2c_device_id entry back, it works, just as you said.
> I will submit a v5 with of_device_id entry removed if that is necessary.

It's not hugely important but I would expect to see it go away if a follow up
set moves to actually using the data form the of_device_id table.  At that point
the two types of table are largely independent.

Thanks,

Jonathan


