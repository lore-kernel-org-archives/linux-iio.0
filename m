Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC33DC856
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276025; cv=none; b=gJQD5T2OxOqsu4Vnj8czpuUouNcVgjlILJyy7IV7FdqzkbsZlOI1/IpQC+/rx0LDEsNSPbWsIq6ZgEp+qynSBRZIZ9eDynsFr9bc+sctfg1cD6i1YkSs+D0qFuoNrp7VIaOUTwUlCUkTaNd7ZkD0Xt8PJBKcgOGGW/SX9S3j7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276025; c=relaxed/simple;
	bh=3uha1lyXdmQ7x72VDIiJdqg14BMev+suh2fIyXoFPqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFXON6O3N1AZYe/im7w8H/RMy9PcS+6sAIeb8peYzIJe+jLWbYmzGnIKChUuDMuW/MDm+szSvcun3fwvyztFQKnhmYex1G+DqWLSFHuEKZn9N+jcr6LdzE56fE1KV06rJL9pXM3KeBNX2h/ca5cHqCnbbmTXqZoZxZGlPkbqnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX9ezI7l; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX9ezI7l"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b966dd74so30354895e9.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784276022; x=1784880822; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L63z0ebNG5Tx2TMavcYbFNcfaVoRzFeosIrJj+Kz+x0=;
        b=UX9ezI7lTk0sSOZyzJn1oM7Qyc2ZPYgKxj/kUgSpRFZQ5VqChaZUiRtBrIwHct9Ub1
         wa648UhgIqwgHDKkHawyIvFBJdGryY5ke7Qi9PmpbUnpRF+haaddt5CVIR+S+PLm8xjk
         Vpb4RGKwq+8paqJxBoTjmJkQ4ho3hgy6ocVOtnHguyLFz78pIuSRVZaW3q0s5vElCwpV
         V+8w2Dx1LvzFCRvWIR3xDf3IGR3EKVjS8e18Yn1kAW2vsOG/COU5MVyz9FUDpnH0TFYr
         meALMaFZJ9YHgj156He5FtGUbKZ/UFu1j/D8FrxkLjgl0mZGSWPT6De5Q9VVzwcKDBaM
         I1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784276022; x=1784880822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L63z0ebNG5Tx2TMavcYbFNcfaVoRzFeosIrJj+Kz+x0=;
        b=SDqmZgD+joU7m+xZQ3OgcaCe+acpnIZA7Od1zsQs7ag/nWGS5cfdda102PTqrRU1vk
         NHZBQ070CYbZmBVAbOUIc3mSHBVo9T0YTV7knjj4snP4/OAwGyus+G4vvpnxpyiImpGX
         qyQN13Ji1QQrzv6Za/b8sgzzaG+cBWbm/6zya/AxeZTqJpuwKWKjiahMi9uoOyfSXX+v
         LIhr1InPJP8/IMJEJFLSmvl/CSzMxxYcVIJmWUTNB/+0RD72tdgbVI3eUlb41+V+VZq7
         K00vSuk19jiC6Z1E/tfFoR4D5KX4nP63hhjCusHcm3/Nv4rtawPd3Tm1aqiAUFjntlLt
         bFBQ==
X-Forwarded-Encrypted: i=1; AHgh+RphUz9TBwF182+hTZSqfvJX1QpMA9sMQckD70xkGmcFoFhkH5hmp/E4YjAgfYmFmbiEFvCbCj60fuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/VMcfDtBpIibOieYwI9yn6Uh5R67DjuJevkBI83UgSrbWgZg
	EDFGbpCDnvUQaKxmtKNd3W3AeMz4aH0ItkdY5VtiI+EJt/EIT426ZXWA
X-Gm-Gg: AfdE7cl+FphCLifCVxtJEa3lBn+DEf2B63hzZ7e6Mi/FMRkydq3P1wkIMJ3p8i3p1zd
	/IdLbH/xLM1YUoB9onAq/zefMn42yzL9BB85d9FwDlUTKiwQVuF0gApuN15LiahMuznPXT30NLU
	7Rncj257aMHC4BPM1xGM3Y8LgnKsdNinCBKLQ3Z6pUzLMtqRr/YdOjEAsbIgrabWpEWjwrBdfdR
	aHxxjudYzy3nu/jkRbvCW218JV0rS4iTiqzQIq1RQBsoIHO7woUcLWcXFEA2EDrV0n33nKuCDp/
	D6aWnmCWghHB7K6yUn1IZ/kImBGdL2sIDkWEknsDl5K1Zt3IB0BQVHEkGq3U6g71BuksMsLB9KJ
	nN/6LRg8tfqHlOnlk8cJ5xFSd3xYSaExv5Jl+ydkOJuBXjYheULWTPXrFfMaXutRocLjAgrsW4D
	BuXNn5ZOep1NuffrwW
X-Received: by 2002:a05:600c:1d15:b0:495:43df:39c0 with SMTP id 5b1f17b1804b1-4954a513abfmr16350335e9.27.1784276021643;
        Fri, 17 Jul 2026 01:13:41 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96f19sm34988695e9.9.2026.07.17.01.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:13:41 -0700 (PDT)
Date: Fri, 17 Jul 2026 10:13:32 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org
Subject: Re: [RESEND PATCH 00/22] IIO: Clean out superfluous I2C checks for
 single transfers
Message-ID: <avufy4eyjrhdteaf57yzrygetgidy42z47uyhbdc6amsl6h42x@kcjz7oh2fnou>
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
 <5e9b7479-ed16-48aa-bd4f-26abc09e690e@metafoo.de>
 <20260716162053.00006f99@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716162053.00006f99@oss.qualcomm.com>

On Thu, Jul 16, 2026 at 04:20:53PM -0700, Jonathan Cameron wrote:
> On Thu, 16 Jul 2026 07:55:32 -0700
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> > On 7/15/26 5:57 PM, Jonathan Cameron wrote:
> > > Resend to include linux-iio. Sorry to all who get it twice.
> > >
> > > This came up in a recent review and I realised I have been giving incorrect
> > > review feedback for years. Both i2_master_send() and i2c_master_recv() plus
> > > the dma safe variants only ever return either an error or the full buffer
> > > size.  Short accesses do not occur.  
> > There is actually one interesting corner case. If 
> > i2c_transfer_buffer_flags() returns 0 i2c_master_{send,recv}() will also 
> > return 0, in which case the updated drivers will now read uninitialized 
> > memory. Maybe i2c_master_{send,recv}() needs to be updated to translate 
> > that to -EIO.
> 
> That's indeed curious (and I'd missed it entirely!).
> 
> So ends up being either the master_xfer_atomic() or master_xfer() callbacks
> returning 0.  master_xfer_atomic() is novel, it's a union with xfer_atomic()
> and no one ever sets it via that union element but given the types are the same
> all calls will actually be to xfer_atomic().
> 
> Could remove that complexity whilst here but there a bunch of related callbacks
> (e.g. master_xfer() in union with xfer() where drivers are still using the old
> naming and I'm not sure I want to chase that through various subsystem trees
> right now (though for fun - and maybe profit) I had claude work out a series.
> Was fun watching it write a semantic patch and spend a while debugging it.
> Glad it has as much trouble with coccinelle scripts as the rest of us.
> There are still a few hundred instances and I haven't touched all the callbacks,
> just this pair.
> 
> Anyhow, back to the question of whether they do return 0.  Yup they do :(
> 
> https://elixir.bootlin.com/linux/v7.1.3/source/drivers/i2c/busses/i2c-cadence.c#L1153
> 
> So any defense against that case would require hardening further up the stack.
> 
> +CC Andi and the i2c list.  Would anyone mind a patch to do something like:
> 
>  static inline int i2c_master_recv(const struct i2c_client *client,
>                                   char *buf, int count)
>  {
> -       return i2c_transfer_buffer_flags(client, buf, count, I2C_M_RD);
> +       int ret;
> +
> +       ret = i2c_transfer_buffer_flags(client, buf, count, I2C_M_RD);
> +       if (ret == 0)
> +               return -EIO;
> +
> +       return ret;
>  };
> 

I do think something like the above makes sense. It goes in accordance
with the expectations given by the docs.

- Nuno Sá

