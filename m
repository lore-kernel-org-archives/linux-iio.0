Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458C37F00E
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238589; cv=none; b=qoK4U47qfVK3TkT6+QHNxOGnco73kRo4D5BqMwsqAlvOFMhFeT5CfZZob9sJ77N0sOEeduA1ISp98hr4xViHx0y/+fhdn6VVRT43ZxiZ8ZbJTqJlOjh0vJX145D3JJQ8BK+Gg3q0ZXRfcliyVuAmi+pCBx0cMp35EAOuXEV/DmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238589; c=relaxed/simple;
	bh=Pf7JfpDwX4+Poty5IvXCho7jfNMVaUeGZfsawai3w+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkdU2nJl/tXcO/O3+SGvyJIfOUTavi3obhCk9D3mlbZYMfFf4jSNKQBjEjiiPICtQhkT07uRX/sXSjN9x3oCRdqcJqi5sXHTphvz9GKQWoRqm1qrbr1P8M7Qk5u+yR5S7szurgEC7MZm40y3iKhjg/50jQTuW9MzR0TTHLAvxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVBRmalP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQ97GUsW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVBRmalP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQ97GUsW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787238585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bdrbfrFBNKxusVF2TTjyC1jQzKOXzXeYZT+7fde0g/o=;
	b=XVBRmalPwgpPtVW5giVwjdxfMZsEwsdU+D0PCpS2MVYdbo0BSXEOVkhFo+AHFupj/Qvj/d
	4Ys4NDrqmg72TZKFX/mAXatmawiL5CVlll1oTnPSWFb/k5RKVbhhWWQozMY/7WmHjNCxa6
	bcOv7t31m0nwnqHXonvEYZv12hOWZ7Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-HMFkQPzpNeu25uy8_E7JMA-1; Thu, 20 Aug 2026 11:09:38 -0400
X-MC-Unique: HMFkQPzpNeu25uy8_E7JMA-1
X-Mimecast-MFC-AGG-ID: HMFkQPzpNeu25uy8_E7JMA_1787238578
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d33c89a29so31692301cf.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787238578; x=1787843378; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bdrbfrFBNKxusVF2TTjyC1jQzKOXzXeYZT+7fde0g/o=;
        b=AQ97GUsWfZY3ZAu8YHlZZ/4M7/r5oVxCDC+sayCSy03SlyjGM2ROKyLakymusVQn4P
         uQwCaD/uWjM3HNVhO3GIyRDZU+yWnkkPg7OZYw2OUtpL337GpdGRUkXAAPDFpt3YWM+3
         gg0HTLQ47p3C6/N8UjnjB/8QGiYp4e5NaYje6YcZeKmf8m8B3QqmDvb/MNPbvwtbAPDf
         d4u4KvY1objv6d59VbONhw3IQAxNeGVacO0ndGTPMRW+7h0kRMQhpOmMCwsXY3U3ITn2
         2w+wGCI8RlQoW2aDZuDg9luevyINmPzk3Fz2VDY15abkFbLTqd/FTTnyktjH7J51f8kc
         IwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787238578; x=1787843378;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdrbfrFBNKxusVF2TTjyC1jQzKOXzXeYZT+7fde0g/o=;
        b=AHO32D+9fbW6AS+AFkMKt0FsWwwLD4qQBXOnpcg5N4NuffPOiIzE25M6Zv+7ykeckj
         8io3665bt6elM68nQOTAvR9mks53gggQSetdTkS4pBuOVbKjUj3kaB0ZyCfq+FfybOFH
         mCk56+ZPn3b7IkK73SwLjeWzWO12aOXQTl83wd7hcW/MRgO08jilYUjcrVfxMVW3VFe3
         oAquPF9kl9ejpf8GGr0tushr6hddVE4Gc52RMC8E8jZLmcLsOT3bZwljhNdpSX5QYt/V
         ljbo3IZlzKbMR50gtxyU2YCCV0ssX7bRkfWfvxha/jwtcTmEDYRkPZuJq0mnlfzmFQ4O
         6Gag==
X-Forwarded-Encrypted: i=1; AHgh+RoNOvsGZSwn0nCKlhW72BbnnoiNKjDVxXDFLQGDST0P4NeT7fLj8PYWAF5zqdmUwLxpUOD28btfhsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNwyQISp2BSGtH4uSscXk6+5ISKRMAVbT3lzYdiJ03qlcsm+Hj
	F6+fgk5NTPjQ7LbVW0eM/Uy9E4N5AkRRUcJT2OdxjdKFLRmWjCO/5NZgFsNGjXQnoKWzMT+sJug
	6V3KejNKfLmI4WNcf3wSWUIdEqmyyoXi/diIi6/HoRB2+0fOeA5bacz7yWn2iXw==
X-Gm-Gg: AR+sD11s+DaCZTVIL+eoKDDMlx6+G+xNB1lkVtmenGnwD+sNypjoMbHB5N6PPqVrSi4
	vdqufIuDCwQfgwANdZwkZpKbNuoRUcCOP+hWewRmNvmaxUjDmUpYsAO2hA/ClowvSt5JZ+n0y+6
	7OKhedptzPGhoJY+ODcbiRZ8dCPXh+oWlGODspLX8bs+M690ev04KSN9YRN1WrROy3237jZhRvS
	LMa/3KTt28VYmg7Za2lWSOPf7NDwasqujBITdupqZW2WRL2dO7+FvujOmDYO3d0OioIRhcduUgs
	W513Tfx7NOqiRMvmH+9fzW4W1TxkElrIwhnG/vtJ+b4CxSyP4kus/rGo3s/q9hKC4LX3eZPejpt
	7m0x7xV63NDiqfdTQAHLnIUidj4D7+zwRW5s=
X-Received: by 2002:a05:622a:38f:b0:517:87bc:9b47 with SMTP id d75a77b69052e-52dd5e04d71mr123094551cf.39.1787238577650;
        Thu, 20 Aug 2026 08:09:37 -0700 (PDT)
X-Received: by 2002:a05:622a:38f:b0:517:87bc:9b47 with SMTP id d75a77b69052e-52dd5e04d71mr123093701cf.39.1787238577229;
        Thu, 20 Aug 2026 08:09:37 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5edb5196sm40682116d6.8.2026.08.20.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:09:36 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:09:34 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: frequency: adf4377: Fully initialize
 clk_init_data and clk_parent_data
Message-ID: <aocYrlbsNqEzahky@redhat.com>
References: <ae48ed1dc6b1ad9e10cad0d9df28d9fab213f653.1787216909.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae48ed1dc6b1ad9e10cad0d9df28d9fab213f653.1787216909.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Thu, Aug 20, 2026 at 11:19:52AM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> adf4377_clk_register() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter is uninitialized, and
> thus may cause a crash.
> 
> Similarly, adf4377_clk_register() fills in only parent_data.fw_name,
> leaving other members of the clk_parent_data structure uninitialized.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: 60e5448ddbec2dc2 ("iio: frequency: adf4377: add clk provider support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

