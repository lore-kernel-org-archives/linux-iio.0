Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22835C183
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 04:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785730423; cv=none; b=rXnN5f0xnrwh/9RczHqudAKDfXEia96vzG5cu9bBspczrRJlD8aHrhx6xkRM8YlSFFMxgmGNBEeURVGPmF1vhPrNEverqcT9pl5fkxN43xy4R5f2luc/WcAz0E3Vexw4x51cqy7e0SUWcOQ+sCvKcqSCJmr2TOObDHPBX7t8ZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785730423; c=relaxed/simple;
	bh=OXLpzJ/H2u+nL8XvKhNKq1KQkvmcRXmXu4aXTGY55VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBvt+ExhkCOUjOPCCQVtR4owc++ewujVP0TP4nGJaGlbbW521Yiktu1VWeI6F7FzmBSAtrIlnImUIKMvkhn2vEtlFwj89dcHhhouy5ParLRq3vR37ITSrU5DH6YXn0JvondoC/B+wyJXFT5oFq5yKCvE6cW/lYOQZ6bTxKM1wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nk4Bxvdf; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk4Bxvdf"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c5382806fso28269451cf.2
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 21:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785730421; x=1786335221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pl04dpRgnSLOgJC5HtXDz9EzCs1SLg5wxfFNPj5wzoY=;
        b=Nk4Bxvdf2jQbqjXHfiJwFk5ZswpxSbinO5qYF5MX53A/07Qj/CVGowX1GPONP1JVdP
         E85xCGMakVUMySZgkcjshLD3AXlCwec+CJvxGqJ5csSo8wBsSeo8M1ZbJ/TtcJ9VeCAa
         iZSPQlkKq9/ZBREVlGS00BYW9gH61xTAkdi7YhXSav+qwDcKp6K58Bb7Z2qGyJTW2k1G
         7NIJYsj/70+RRmOnfHSgkLmd8uO/nR1H3w++aRDX3gwSHLFjpgYv+c1kepJTnbSkdyrx
         eAxfWYMaUvHoK28kHTZZHsPiVGMjanODR7DJGbFanq/4DZ5ZB8AQlrAafb6GRQBCxxhJ
         colw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785730421; x=1786335221;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pl04dpRgnSLOgJC5HtXDz9EzCs1SLg5wxfFNPj5wzoY=;
        b=dRavXidgjWq+alNO9d6hmPWlm+eVhQ/SndoSnnX8s8tz047aOx/vzlWJfANkmM9OM5
         9wgUulb7GdStiOeGhaI4yBeDSDEV3pIeveDdC73ovyVCK/KZg0tFnLTyKVMKWpOvFIWP
         5j526FbBKQnC3oS4v5svawGIawtwXISAkKutPS0BrGMSQuYkvbO6QCk7SaS436SdmCNM
         1JvfdbvoYSvo3FYGWcYqAvtJHOmD3C+XlfaxgV58H9LZpursQiqSO6pbv2czg8ilLTiJ
         ZJdaQZEuilo1pX5zyF3trDnBSU4JrNtuqO3SpHhKeFIjmRVpEs/5uHZLrBOyD+JAPniE
         QQVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfShAkBINkz/w+o1coSru03PjbfEWVsUj2ongEoJ5DQ4X5o1NHyz/fUC5mw3YvOVtzbGjniIG8Trc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZigZb/Vm+wOqOjWLRMVaVocxhnfw1GadjiIoBGBPaacb/oOye
	BpddtooDnc6JmBCJ2Dgi41vqrT6r13zhtB+IBZRY5X8A7PPDwp/QynXG
X-Gm-Gg: AR+sD11hC5h7ksCbKoVRqQkPOKTIOsCaPlagiwE09iIXkPCNrtnNvX8i08BhiVEm5jF
	8/DBdhUZfx0SHwLn9K19CEy4+oYAAKPWeh8C0IVNSjmxhreMaJjAECoMX7kkaJlv02H4gNWowUs
	Z80DAkcQN/kKitz4m0KhIwKcRpNgbaGs+ao5WLnJzIfXMlQ65NOWf7K947hcYXVLkSDztqwlm/5
	t4LUk3QaFVVdDCT8dB1ATiPT6BkkpEtuJBUYCLW7WdORHpbFnHHdNUydFNPChMyzbInwxts77Ir
	ohBZOnlQYHwNelV7O87oJtOE239kzFZkMThcbZVeO7FyElIZ7uTVxQwkcsYQvQTfqOyQ+7OnT2H
	ZV3rsCJeZQ5ePkKF0dNllFSVEB6dfvSv5kafctFj2Parg3ZKtStjZGm5V8zQySRTeg4PcviMtts
	Trxi6u2ocEqPKbalUz2RZqY1XzNtPbifw+7XgOszFWsFOUOMXWTQ+D1+FB+BSH5oIo9Kw=
X-Received: by 2002:a05:622a:44b:b0:51c:1fd1:e755 with SMTP id d75a77b69052e-52b567915e7mr145099021cf.36.1785730420860;
        Sun, 02 Aug 2026 21:13:40 -0700 (PDT)
Received: from localhost ([2600:4808:5693:8201:bb19:d9f0:6e53:91ed])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4eb6a857sm52935101cf.17.2026.08.02.21.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 21:13:39 -0700 (PDT)
Date: Mon, 3 Aug 2026 00:13:33 -0400
From: Marco Chen <marcochen.dev@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	pmeerw@pmeerw.net, matt@ranostay.sg, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v1] iio: health: max30102: fix NULL dereference in
 interrupt handler
Message-ID: <anADiCtmoVbT0o2F@xiaolong>
References: <20260731184124.112124-1-marcochen.dev@gmail.com>
 <20260802032609.27900bb9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802032609.27900bb9@jic23-huawei>

On Sun, Aug 02, 2026 at 03:26:09AM +0100, Jonathan Cameron wrote:
> > +	if (!indio_dev->active_scan_mask) {
> 
> That is racy as this could be going on in parallel with the buffer being disabled
> so we check here but it's gone before it is accessed.

I understand what you mean. I will remove this active_scan_mask check.

> Which leads me to suggest alternative fix - check INT_STATUS and if nothing
> set it isn't our interrupt.  That doesn't get into the potential buffer
> enabled / disabled races but should close your condition I think
> - looks like it is read in the fifo part below. You may need to refactor a
> little to not read it twice.

This makes a lot of sense. For the v2 patch, I will plan to read
INT_STATUS once at the top of the handler and pass that value into
max30102_fifo_count() so it is not read twice. Consequently I will
remove the INT_STATUS read from max30102_fifo_count(), too.

For checking INT_STATUS to see if it isn't our interrupt, instead of
checking if nothing is set, I was thinking to check the
MAX30102_REG_INT_STATUS_FIFO_RDY bit specifically because that is the 
only interrupt enabled in max30102_chip_init().

This will close the reproducer I was hitting earlier as you said. Since
we only ever reach bitmap_weight() when FIFO_RDY is set, the NULL dereference
is avoided. I think there is a theoretical window if the buffer is disabled
between the FIFO_RDY check and bitmap_weight() call, but as you said,
closing this would need the buffered mode claim. I plan to leave that
out of this fix.


On Sat, Aug 01, 2026 at 16:18:00 +0100, David Lechner wrote:

> This is one of the reasons why you are supposed to turn off power
> before moving wires. ;-)

Fair point, I was pretty careless.

> IRQ_NONE would cause the handler to just run again as soon as it
> exits, so it is almost never the right value to return. IRQ_HANDLED
> is correct.

Got it. I will keep IRQ_HANDLED for the v2.

> There isn't anything we could do other than log the error.

Understood. Since the INT_STATUS read at the top of the interrupt handler now
determines if it is our interrupt, I will check the return value of
regmap_read() and log the error on failure.
