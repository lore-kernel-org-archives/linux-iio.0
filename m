Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA81A9FBC;
	Thu, 20 Aug 2026 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787190555; cv=none; b=CM5SAVXm4tan1AnAisiMSln45fa/GFyKchZC7ouVsAMY3tQidoJzEkPfsBpJNgIid8npLRLmilSAoioESyv64nIkjYHzxxEjSiBIr+ZuBLF7FHOeJOI838mmUpvGGEbzG+pbYMfhN/lv5AkFI4JyDxgCNjWHUPvYaBAIhOq7qpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787190555; c=relaxed/simple;
	bh=1rLsfunHbk9SZIIhirNDFSdzerQ5+ph3Ec21SAmnjUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jv8O/dP47Il4FKsESIsu/9zaNClq2WpPI4ag+rfT3vdi/ZaO6+onVWPUIOLaIHHKoNH2meaQ7OKM34AfhPptlLaqf/F1BHotUx0jQya8aRD6xt5SeoFqNODLIGVqo8byBCwH7L9CsPj7+gurMlyVus6lzzYN6EHWqtLS0wlhO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbILFBFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbILFBFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEEB1F000E9;
	Thu, 20 Aug 2026 01:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787190554;
	bh=+FQius/198h7jxvfsVSvKuWaChk5OvO2qzBkuGlU6ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AbILFBFMkQ7YwP7nm1JBfW0dgXT0AsPPBlk1n6H1Jk0X+pDsAWGJ2Xd7WHumxYfXN
	 iW8stVifylkc2o1oioWBBi2+jhcrvFxGIHIAmJ41nrtCiQSxOYth/ouAgQC5QbbkW/
	 hArRpbK5DVBpTCmVVUCJm8GTLAm01vsWgyhum7HLgaeWmde3ZvVNW0GCoJ6bvg9VAK
	 c59kGmu8QxftlyiE/7l5iQGZRVQ3N9SqPwBrqJErq30j16WqWSYlcs8YnWWXyEbuyn
	 eLa3xqiJNCCZjvDMu1FnClwSxKVQt/t5QHT2QipuF2RxBerauIlkyVe+YCwqIOhuKp
	 p5Z861HmVilUg==
Date: Thu, 20 Aug 2026 02:49:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Wang Shuaijie
 <wangshuaijie@awinic.com>
Subject: Re: [PATCH] iio: proximity: aw96103: Fix early return in IRQ
 handler loop
Message-ID: <20260820024909.307601c0@jic23-huawei>
In-Reply-To: <20260820024653.251ac6a9@jic23-huawei>
References: <20260819210826.14395-1-salah.triki@gmail.com>
	<20260820024653.251ac6a9@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 02:46:53 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 19 Aug 2026 22:08:26 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
> 
> > When an unrecognized proximity status is encountered in aw96103_irq(),
> > the default case executes a return IRQ_HANDLED. Because this happens
> > inside the loop over the device's channels, any remaining channels are
> > left unhandled, causing missed events and stale IRQ status.
> > 
> > Replace the return IRQ_HANDLED statement in the default case with
> > continue to ensure all channels are processed even if one has an
> > unexpected status value.
> > 
> > Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")  
> Hi Salah,
> 
> Interesting little find.
> 
> So usual question for a fix: Have you seen this in the wild, or is
> it code reading / tool found?  I'm not against changing it but it
> is useful to know this for attaching different levels of importance
> to the bug and hence how fast we merge it. Please add a note on that
> to the commit message for v2 (though let it sit for a while for others
> to look at)
> 
> Is there a path for this to happen short of corruption / broken / 
> malicious device?  If not, no fixes tag - it's hardening or a useabilty
> improvement rather than a bug fix

+CC Wang Shuaijie who wrote this one and may be able to provide
more insight into why it previously exited on this condition.

Jonathan

> 
> Thanks
> 
> Jonathan
> 
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---
> >  drivers/iio/proximity/aw96103.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> > index 8fbb755dcae0..b1f36a51d56f 100644
> > --- a/drivers/iio/proximity/aw96103.c
> > +++ b/drivers/iio/proximity/aw96103.c
> > @@ -669,7 +669,7 @@ static irqreturn_t aw96103_irq(int irq, void *data)
> >  				       iio_get_time_ns(indio_dev));
> >  			break;
> >  		default:
> > -			return IRQ_HANDLED;
> > +			continue;
> >  		}
> >  		aw96103->channels_arr[i].old_irq_status = curr_status;
> >  	}  
> 
> 

