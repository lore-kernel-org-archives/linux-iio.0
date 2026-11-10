Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289167;
	b=MY74TJq/SjeFm1LNHu19MBMbAD2cUhQTRC164RWbTVu4KUypK2e2JADDJvySbbPAEddf
	 yO8OSnARyUODSifTP30WcmgmiMangzrL2wCLJbEng4CSpo/+YXClFPMRamPvftq0LoJHs
	 Yn1jvJBrQnO8L0fNQ9/iRt0RYV370sYRML6kubtoJKG3kOCZMa9xYFHj/ZxrTDAkgnFZm
	 dQWYiOnwVNDiWknP2pT4wEz7em7ziBA3ducZ+WTpvkYWhyOstZN/EUmJc6JlkxGs9IJNY
	 IMau9u05qnXS224lu1r9UQzRjfHbxdjpMPAgZNzlvva7lEXIQ21bZlyAvmSiGWr+fRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289167;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NZXjw7iHdBYOz25+dloLm4rv1gSDvBYEq3SFSQ7c0Jo=;
	b=QYh0GbFgOAQ5wvoW5bAP4h1SXyCAiBCyb3keu/I/vA2+AjcT/2YyDjOSxUpEZvkQj/un
	 mPxSHVZvL+4KexBkqIgYEWXVLyhevVYkGjL9a5dWfbio5YSi4jDujJ8Yp7jSxL9rIB2iX
	 hbnS70ATMlb9vSo9SjviOzAu4GQsQlOZ62Nla+sjrDYjM6ewAJOqeEUu1S41uj1Mx/Aie
	 cSukPIClH7MNYKGuim+vTrjVeYFVlbEU5Ey/ekyZVNq+YWEok4Pd/QDouaGTR7H13MDM8
	 ornQEfD30B4jsUrzYi4c1mK0SvAesKBehUfOIaP9wBq7imDRt4CABcC5ny0PG37vBHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q11nkyxb;
	arc=none smtp.remote-ip=91.218.175.59
Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31C606A32A
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 05:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA31C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q11nkyxb
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BeEpc+Ak8iIFPGrajMqKB8SxEGKljrqyyyjENWLZtvI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794289164; v=1; x=1794893964;
 b=Q11nkyxbklIE7a1OsVUnYsONQBP5jWofJRTEVU0/oWy+6WSrq/bHw4x4gRHBRY4SwsaMdsdp
 BYsG96ilsPlaO/d8VUJKJvWIkyJmkfmLe/paVGp/pwYf1d6FqQaeKKoZepI2k692UO0FCFZgp8r
 Tdy50+7jtPYLV79K5wddcwRs=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 13f18eadacae033a;
	Tue, 10 Nov 2026 05:39:24 +0000
X-Mizu-Trace-ID: 13f18eadacae033a
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 05:39:15 +0000
From: Akhilesh Patil <akhilesh.patil@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, crofts@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, alexandre.belloni@bootlin.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
	akhileshpatilvnit@gmail.com, akhilesh@ee.iitb.ac.in
Subject: Re: [PATCH v2] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <20261110053915.GB2506228@u5ce4748bae3b54.ant.amazon.com>
References: <20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com>
 <20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com>
 <avG6iHBBDp0ATTsi@ashevche-desk.local>
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
In-Reply-To: <avG6iHBBDp0ATTsi@ashevche-desk.local>

On Mon, Nov 09, 2026 at 02:20:24PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 09, 2026 at 10:44:43AM +0000, Akhilesh Patil wrote:
> > Move to my new linux.dev email address akhilesh.patil@linux.dev
> > I plan to use this email for kernel development going forward.
> > Also update email address in few yaml and driver source files.
> 
> ...
> 
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -1030,3 +1030,4 @@ Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.com>
> >  Zijun Hu <zijun.hu@oss.qualcomm.com> <quic_zijuhu@quicinc.com>
> >  Zijun Hu <zijun.hu@oss.qualcomm.com> <zijuhu@codeaurora.org>
> >  Zijun Hu <zijun_hu@htc.com>
> > +Akhilesh Patil <akhilesh.patil@linux.dev> <akhilesh@ee.iitb.ac.in>
> 
> It's not a rocket science to see the order in this file...
> 
> -- 
> With Best Regards,
> Andy Shevchenko

I missed the instructions in the file, Thanks.
Updated in V3 patch.

Regards,
Akhilesh

