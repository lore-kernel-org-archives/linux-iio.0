Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9BC3E1713
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407543; cv=none; b=Tax671+YBBVMlv6XVaXUfc+427KJCy9CIaWX9W5usZZx3Fom2pOq7BrcMtPUmUdIuMWgT3/BbK3u7Dl1kjveifEAVcm2BenFcIXhiyaNxUiJughmrTNQOhUfPTxeth3Sm+F1lUxnfCFi6Z8s5EfXBMZQjBwQkSet7SS13rIddZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407543; c=relaxed/simple;
	bh=ZlTbIgMZvarBl1ECbGtCjVCPTtmmar20hacxFRh6Wuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhluTWfRU2EkuVH19i1KMHAAy6UW6Zs82l9K+9zz5A7cRdCO/fmm6UfYgt+JiRg78u8hLYJf0Daj+BE065vASxkRKbWTziGDPqERQ5goN9pqPQ9Vnt4kzz2iQWg0zFdub+vV32iX3jnX+GtPJOmW5H6ElcIJxoopQpOnqt5tTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABTx5Odp; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABTx5Odp"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bef8b97655eso101035566b.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407541; x=1781012341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cOztZqPoUk717ss8/D/BbRRexRjj5joOSNpYcM+a8A=;
        b=ABTx5OdpbGnA7LuSr+UMQot1N5oBDJEXxWE+SXMVjFUB4vd0JT2peOyQ4kb2S1Gx6D
         uYPLNLwfnrSl03I/wlTJJIXVCVDlCp2cjAtNhFyfRu9ydQR2Z6eDqV6UhYdTNHnme2hZ
         +umVvF3bBCrAddmPYrjRB/r5A4JOBl5qQjrgP1T4ZLqU5Zzmh4ByCQn+vRRj4D31XMtx
         GRtkPpMoQsf0kKVrqAGfC/jaEcHe4svYpcPBEqs5gWUJRyCyXS0AT6XOLMbjVpMTvv7s
         MhV5dfCJak0C1JR8QK/vjT7jG716FmmcbF2HquwllFH6Rgdpzph6Hd/80KtBQXn9tOZq
         YHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407541; x=1781012341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cOztZqPoUk717ss8/D/BbRRexRjj5joOSNpYcM+a8A=;
        b=iKdUUXNOQp76ywEnwl1sINm4D/EXyanWGTROOBKt2IABMj7MeUZUxNRULIQw1sAvRJ
         xk335AnGyRhKzh+2IBF5e11BDfCjL5SSpuZRbYPsOZlUni/o8pI6PPGfgIn9B7ByMYhe
         P34OZ2xmCE8uP7qK++jdd01qMOF+1OJB4n4KxOvElpi95Dw+rcswiRU1wSldy9Y1k8mE
         0NkerpZWaj5kdr4g7v27Kz2y8k4nUvYFyt2RmAhnoybnFjbqTDnpfWDjxVgmf+loH7ls
         eZR8qDVC9NLGaLpkKQizPCxn3Z2b1UEFypxP/W0oZocn/5s9RqW/lPxAWMGL8xp4bmLX
         3mdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+AKlhmKxqYsQjlUVrQZZuNVShnilzesT/6KoyN43RXtO+aIgBaQW61fNCmSrVyNLYv/NGvXjk6p6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNXCjp/ID/7rB2QAwFkqpp0HuU6WJxAuuljllqA6zIjlCpCh0V
	aqV1frmSET2CGdHVAH8FAyVMRit9s7Hzxb429d+013mgpN2/cgw0hkXK
X-Gm-Gg: Acq92OF1dLhPKUKit+Emtghg1szi114+3c7h7U5zN8vylQj7xw9pyp38QoKyazeA1Ll
	oC1iwX9lVxTEwgTX8TZn3gcDmOdyjh56mRyfP3wZ0ZO2Sl3+FnXtaCTHKs16c1PwXVquoH4CbWp
	1IEeJ5cmYr6Gk8ktpTVlzYQSCM7ujUGpHxKAJt8q7obfsx/HZ5Vm6SDreLwZaQ97MYYChwkv2yW
	JIgbdfWiOopOjT+2NcELTNcg6xfN+AO+quKumWknM4zjoJ/+wsSZ0ojvAK0jPJGekjRKWKO6MG9
	Zwe48kQabj0l5R+kNSvkwLdceN4S8I3U3RvH2opVM4OFjM7YED9G3lKvp+Q42Y0WaGdLA23hcFd
	d6HpXOJ2twuUQQLkcl4WTO+GelIKCsXvxHrxQQsfBd2gNmhhvnkZpsZRT8WoEEdHsquAYiJH/Tj
	CqbloIEyesT5mLVnhqNaR8OKxa0cH8Dg==
X-Received: by 2002:a17:907:a089:b0:bdc:f4ef:ac33 with SMTP id a640c23a62f3a-beefd0bf98emr258053966b.20.1780407540678;
        Tue, 02 Jun 2026 06:39:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bee4092940asm208482866b.11.2026.06.02.06.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:39:00 -0700 (PDT)
Date: Tue, 2 Jun 2026 16:38:57 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jad Keskes <inasj268@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: iio: addac: drop CamelCase from adt7316 symbol
 names
Message-ID: <ah7c8XZHmvWu5eI7@stanley.mountain>
References: <20260602132534.101554-1-inasj268@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602132534.101554-1-inasj268@gmail.com>

The V in Vref stands for "Voltage".  It is supposed to be capitalized.
In this case correctness is more important than checkpatch.  The others
aren't checkpatch warnings or style issues so they're fine as-is as
well.

Also you renamed some "DA" things to "dac" and it's not clear why and
it's not explained in the commit message.  Try to be more careful
about that going forward.

regards,
dan carpenter

