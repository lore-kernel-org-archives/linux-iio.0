Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495916;
	b=sTQC+YBwS+qkMblO35Wsnt9+ull8MucHujMnx/dtTuIptY5nMC6ZRNt9yPFAtZrTDkdC
	 cZX9fJw7Uj7seM4rXGq8CjLNSirQv1WueoGO1Cc1jjOcv3VUyzDVIXogT4JCrQyWyTU/O
	 o/eYW3qwHZPdcEppqH5JdXIQGUzCzXW8uG2RDShiZEp2oh79beUHKVJDahda1tKgDpeKn
	 bROyCdmrr7U6Cvdy91MyTF180CFs6TZuDjkylIpXQpWCluSxQTOUR5gnGhm7BY4b0gXPF
	 yc+6k8naII61ObRk0LmtwJAOQQwDN3bz1CYpfr6BKZIGgwexY/OveY3VEA244DOxtNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=S7kwDV6MelTeL1pkSgLuYwh13YG2X8zQTd6fWfAoYbk=;
	b=KhLypnJViRp0KpDEXZo1GFdtyrDbFzEKAOyXzGxgmgVR/TEUEkPmbvr7nQtsOWzKbEGR
	 +1AbyInVw/jw9MsmGEisLcDELfv3FFK1dWmfeMKm5srvcQpKK737B7gl9VXTQpe6Xdyek
	 8UuqCkuC0PFLLJP0cnNrjMlXnWLjc5RdHFEcQuSSvw5QcEffC40wELTK8f5UrSLUv2zL2
	 kDWfqNf6I9R100Qsr1bxVzHe/8Dh1fk/5Yh6vmze+Hx2JOPFOcvF0cT8cKdBiz7ZzUAFh
	 85osM3uWXZyU7oci5fv02X4+KBCKI1XcYjjVIK613IbQLWeToqm+Thot2qS5D5e4jJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O828mUDh;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B427606A31B
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 11:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B427606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O828mUDh
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2214902f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792495914; x=1793100714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S7kwDV6MelTeL1pkSgLuYwh13YG2X8zQTd6fWfAoYbk=;
        b=O828mUDhEAgpmltNJDuaX9/H3ziuDjwZFgXzLyiLINN2bHY1apklnQay4+Na0cKKA9
         8w781IzbOgs86t6mEr0SxZTucnmGz76Pi4Q60U5RV5W0POWZL2xWYR3S+oOooLS1a9/Z
         eKp5upvvjs+CP1I3kUPhvh6XgHOIYv/MBhRh9pd1MqKpMvPXHr/KhltgaWL2qIJjtcEh
         pEj3HNsuVg9Y5O3E74okI9Zuiv9x88Nh0QLFXWL58IZ/GEZD+0joaj5OwvE0JkSQRt2m
         umwcrwUH8qw9HksNLBc1xqNeitGTx+Wrt8b/m/ElixxiJg+jzl2GAhj8enHL66QKtqct
         kTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792495914; x=1793100714;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S7kwDV6MelTeL1pkSgLuYwh13YG2X8zQTd6fWfAoYbk=;
        b=AFsu/Se2ZNegBibe9a8C+Q2+bBprF6d9mcduXV4uNt1x83tQxEbXultl9QRgP3lBeY
         7eOBEsV/gsLnl9qiWRqomYmXRSetxgOxcOVIj5QW3OyRKc2Px9J3lmLrTenznIXPglWH
         mbE6TpqdJX/KlIq36zo3/9WlBRji4TOXUz0l8VehZYEmvEbZbW3mMrc54gHz+8RJg4kr
         HakxXldFTZLzfBlxh5aC1pdkOKTltIxUiPg5rXx6MtOgfLghb1eL91gNdM8Nek30VhsM
         qyUg/swaDjvYbrio3uHGZFZchIClCqyqK/wy7foNcJxdOUDtS58kWtj45IY2/mrMuJdp
         WO5g==
X-Forwarded-Encrypted: i=1; AKwUvBw6epSueUYNxEXgJK6B++nEpYgpt6xymVioe/8SGmtY1fhoJJqQw/JxnIXqnPqoN6X7F3cAJHRF7+w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLY/OioMNyxxcwGLABJ7rBhIlsUyyQwsQ30mIx9bjKBwT6HDTB4
	7hj5SE94/qS/V2iBzknTHiGSmzmiatY/XMxhbUoEF5WXpoQlUpNzjxLG
X-Gm-Gg: AYBFou1iVk/xDCwFQH35xB0g/Yy4Rd0xMBt7GB5z5ghtXPv9sgHWUju+6uUzyPh4DCt
	6V75LNMmLlZbkkLn/NKEEZpmGVq1Or/4thc8p+cD5LuBILB24I+jfUaETcvMKnbi6Cm9iV5+fDr
	GyAv55dpbmPixw/YNFH7GBBPibjyn917JEf2wTBI3Hz2qr1gwLJYtRzuKgwm++tJAjTAKtbHrCX
	GTXEzgVYArsNGnmEmE5OWuRmSHJy/Zo0QLZhGz091w4S8xY1hsG3vZAZGxsnW+oW6ZRREgZfxTy
	Y9B+21XxzX8D6yRyHMt4d/mNhkOmUXuDEJRI+q+17HBZjGjJCC7zutN8zBXv6UFf4Aff2dhmm3p
	ZH4HUTvarp+H51RYRtqKtXZGbKH0j+cJhbvNAoKEIOcSQJj5iGuZVBPlxSWD8Zwfvc0sItBlO0f
	wGC9nQO7YzROLzbDTHDBLpos5uEpXmc9m+vXFdII9mtNk/EDgjh5dg1KPz5f3MIBtVICREFiZWh
	2Ph9FelYdG3wwlI7C1XTlCe4l2zvdBY+lg3AsM=
X-Received: by 2002:a05:6000:2601:b0:48d:fbdd:4132 with SMTP id ffacd0b85a97d-48e07bb30a3mr24304766f8f.18.1792495912842;
        Tue, 20 Oct 2026 04:31:52 -0700 (PDT)
Received: from localhost (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d80fc6csm5348902f8f.14.2026.10.20.04.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:31:52 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:31:51 +0200
From: Jan Remes <ciakval@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.triska@mycroftmind.com,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: Re: [PATCH v2 0/4] iio: light: tsl2591: fix lux calculation and
 precision, add I2C ID table, report saturation
Message-ID: <atdRJ3JqAyGWOnxf@mm-ntb-00805>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.triska@mycroftmind.com,
	Jan Remes <jan.remes@mycroftmind.com>
References: <20261014141650.259929-1-ciakval@gmail.com>
 <atEdM6wi_FAGFjrr@ashevche-desk.local>
 <20261017031411.05dee323@jic23-hlaptop>
 <atXSBHbOPYYltHUW@mm-ntb-00805>
 <atXZwm5DzCK8S0_K@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atXZwm5DzCK8S0_K@ashevche-desk.local>

On Mon, 19 Oct 2026 11:50:10 +0300, Andy Shevchenko wrote:
>
> On Mon, Oct 19, 2026 at 10:17:08AM +0200, Jan Remes wrote:
> > On Sat, 17 Oct 2026 03:14:11 +0100, Jonathan Cameron wrote:
> > > On Thu, 15 Oct 2026 21:36:35 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > >
> > > > From my view (haven't checked the calculations, though) this looks good,
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > >
> > > I'm guessing not huge urgency on patch 1, so to keep things simple I've
> > > applied the lot to the testing branch of iio.git. That will get rebased
> > > on rc1 once available in a couple of weeks.
> > >
> > > If you want the fix to go in faster, shout and I'll do that at risk
> > > of slowing down the rest.
> > >
> > FWIW, I don't think it to be very urgent, as people probably don't use
> > it on x86-64 (seeing both as it had only DT probe support and that
> > impacted users are likely to have noticed the oops).
>
> What do you mean by the second part of the sentence? It's as easy to use on
> ACPI platforms as on DT, we have so nice trick called PRP0001, which allows to
> enumerate "OF-only" drivers on ACPI platforms via SSDT overlays (or other means
> of DSDT/SSDT provisioning).

[ Sorry for the delay and potential malformed e-mail, I was trying to
interface mutt with my $DAYJOB Outlook e-mail until I got the idea to
just export this one e-mail into mbox. ]

I did not know about the PRP0001 (thanks), so please disregard that
argument. Still, I believe x86 users to be few if any, since the oops is
quite easy to trigger and AFAIK most x86 distro kernels ship without
CONFIG_OF.

Best regards,
  Jan Remes
