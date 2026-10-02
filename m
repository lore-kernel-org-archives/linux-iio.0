Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AE41A517
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948469; cv=none; b=JabGvL+JF4yVSOVPSaXVjY8f9VXneJzgNGEXswrLmaOqz7C+DCd9+hORfLm+jizeCcjSV0BvksKQQOxOvdOef9q+GzI+tD6R3qBQSe2+LW/F1y8kAWsSG/OPPj+4EOA7ABhuMzGSS69wSU/4o4NzUUNr//2q+YGUgFbs/dmeHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948469; c=relaxed/simple;
	bh=WF9Y0Q2ogSkQ2UZ2v1wgAF3ztz4coOd1/SES281qYf0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B8ihg6TJ/FUgg/Wk020JIabm2vpIXG907mDbzPzWx6CIudkmdmw/d5C+VwEDNCaUtocskKxawo0Aoj8SW8ZYkyTQxK5B/mi93X6idcboS8OqUGyzqkrigh7WmjViBo3cEa5MVetUMMfACiCgMv/wQYrPhos55tNBbHYsyDJeGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GcemxUY/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dHw877FL; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GcemxUY/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dHw877FL"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 306DF7A015F
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 09:41:06 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 02 Oct 2026 09:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790948459;
	 x=1791034859; bh=fM/+6xWChtAgoe1b4ZkxsQoYtayqo7VPboOZkOybYqw=; b=
	GcemxUY/SBJnxnDDbNql4FJ8nDSq7LmY/dwMK0QWYNXfSppSKadmCqzXR3bBAV1s
	Guq0lbgm2XJuyjPEidLfWDZbVPDFnCGjeD0S4wXcoyNva1RnnQtipSfFL4wwm9qV
	AtltD0Xs7r/IPnZ4lRwtt4na14N6iSRdalmnkXwMh+YtAxdg2vVRcRpBpt+sYS5G
	+GeH5SdWuX1CLg8mvYuJf9agZQn+Ti2304egpeRmRuUImut4SVS/fnmhS5UL225P
	636/Q/RX8pZvxVC0jl34yDYPPD5fP8kGzetEZIeIjG/Y2Zh/OVSrxGaLy56Fc/ji
	QiXTnHXkf6tBdFaTi2upxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790948459; x=
	1791034859; bh=fM/+6xWChtAgoe1b4ZkxsQoYtayqo7VPboOZkOybYqw=; b=d
	Hw877FL0sRk/FmVAhFMeDF5ZyZwbhfvluZk7nx/Wz3GN96CYgMUhZ9+GLBjWpsFl
	fxTloMB1N2RmANqEF7zDypSdxJCe566xrHXcP0d7xKySTJ/f2QmA07XcRjvnc7P5
	FWfJnD3Ps5U4IHSRYrMwjRFPK5FF863j1/n7Zag7O2qfDCkhzY4FMWEOfWYidAqb
	oDi5SaUeRYWVRov9tF4Td3pbe1tK4RIWv1qJltLKyo0cznfXbhL3i1lobISIuviO
	cuNA0bMf8URYWuBgI0LPxxTS6+s68euqyeP3HdG/ftzI6j7G1uR0liyPfRUOJEog
	PwTq4JFSYP/anFax3OHcA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790948459; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:THDv3RvB+0w/HcBSq38ZBuIs218SJhNblfZVVmwYO+z2V0V
	wRnQJjHjDRJS4Kxzi3yMnWAm5G8tgjwt+ZFdFdU7/gprtENNk5vsKIubUjFUFCxw
	JDnIjT5evcWJEU0/jy4lNSiyoiJx3is0kUZol6ijTcx1mBszqLe2EPIZMOHOTfaK
	UtCCkpjPO4g9awh2l5eYGxwOys1FfxW2QQAtoQ7fmTgEmo7g+n9GBj0lkQR7R3Lb
	8/n9OlQGbqvs6ZjyCcfnDswTZURt1daTagdDp14h5kMwjH3k6tuXWVsWBo3rXABr
	ZCFQ1XVRFQlJdQzbW8fdpdRjUUuSFSNYG7wP1xw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:W3Cr/VU64tn7VBE4m8JIAy/UCojKXZltl2+pYSlSrAo=:WF9Y0Q2ogSkQ2UZ2v1wgAF3ztz4coOd1/SES281qYf0=;
X-ME-Sender: <xms:Z7S_amGwnm7wCzj48TDa5ZoeyAPfaWgYz7Peh6hGd0MpiMQGtEJPqg>
    <xme:Z7S_aiITAz8nR1eICNfrMMQCnjYTJoulgE-rHxy6QCXtOv5a_HcDXVdl-wvL7lSK5
    xYWQSifbUF2368l7VtigktEE-6WTuorT2QwjAEtim7LNzvc62Q15Xk>
X-ME-Proxy-Cause: dmFkZTFQL3hfV5r5MhVUGZWcq0kdHOIvISgSh0pGvZnE2T4hOzH5GzYzHwxxQG0GwqecmI
    nLaSZXoMIIYT3yGuQOMOdL4JN0OV3nb42SLygw/FntFQ4rkgRx16mhMbov+6sdstKwddoe
    +sCLXq7ART1yAFxDC22p1/WENMt7nx531xHRCrELlgzWRuG/0AxJjxXcxHIJcaWSKfCRWf
    6z95NYmLwp3dlp6YSNUUQEMcZrQfa2wFFl18ZnQJAeJ8vx8whMJOSf1l027j+7tPFz3Xx0
    AMGIYJcjJng17u/9elLzEpvFpnXwV3FPlo+DfoJpPNyTDfezrRDYWlubCeaMoJlkIpbSaL
    OQ3ZCgt5LwF3YVK7tqk8zCe2rDq5HuLDzYdZ5GE3hxD7aFc6mjpuTuCxA/p4xWLzEEaVGR
    PX8zPRMUpcKb4XErq3L0wHJyT3OZOeM24dF6QAnoJxn4wYVwDBzOVcvlzR3pi3HRXwesUy
    3KM8H6X45C5XXXCZuOEEl58IO/1mD5viONi29d2FeI1T2NL8qIPshzMb/ZmtT0fXkVJs78
    WxHTMPDcS15LFcvKrU/okpkGlhDqThp+Vxit3hYDtxuxQP5GBal/T3DTKQ/rfx67U8+VSq
    B2NcLDAxognBxhgym0D6f58oNoaj/M+mCGxhDRBIvyGcdF67jcix4Y+zxfDw
X-ME-Proxy: <xmx:abS_alcMEvoeDwDks0nGi6gHc4wfz2Oo9p1nYe5GrIPXI40rDB0VKA>
    <xmx:abS_arU8-K1kGquqFNvRn9lIkkl5Asp7_49TLAQwYtq8o_o-pantVQ>
    <xmx:abS_auCEsc_WTPTutwSA70FyOkOwZzNBxFOmlUt_fiIrNpczMMRPCg>
    <xmx:abS_au5R4fxXhdHEQH_OMqfRrclUNe2VxP8XGKCwsXIOBsz8qkbIUA>
    <xmx:a7S_asjxf4YrFDEA3Tc25XGZsquTQRPkluF7262ImPwuLH-d-fbDzZcO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 834E732A008E; Fri,  2 Oct 2026 09:40:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARQvA_lNeCZZ
Date: Fri, 02 Oct 2026 15:40:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Nathan Chancellor" <nathan@kernel.org>
Cc: cdcp206@gmail.com, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Jonathan Cameron" <jic23@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, "Andy Shevchenko" <andy@kernel.org>,
 "Liviu Stan" <liviu.stan@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, "kernel test robot" <lkp@intel.com>
Message-Id: <732d7dfd-172b-46ed-94c8-1c550cc682ce@app.fastmail.com>
In-Reply-To: <ar-yaTw3gBFde0iA@ashevche-desk.local>
References: 
 <20260929-iio-ltc2983-fix-string-compare-v1-1-d67d612d6ddd@gmail.com>
 <arzb0JQxkJAsLsEa@ashevche-desk.local> <20260930150336.GC3142230@ax162>
 <ar-yaTw3gBFde0iA@ashevche-desk.local>
Subject: Re: [PATCH] iio: temperature: ltc2983: avoid string comparison for leak
 detector
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 2, 2026, at 15:32, Andy Shevchenko wrote:
> On Wed, Sep 30, 2026 at 05:03:36PM +0200, Nathan Chancellor wrote:
>> On Wed, Sep 30, 2026 at 12:52:16PM +0300, Andy Shevchenko wrote:
>> > Hmm... I consider that the compiler warning is just a noise which we should
>> > ignore or disable. It's doubtfully useful as if it may prove the always false
>> > or always true cases, it doesn't mean there won't be other cases in the future.
>> > Do we have any discussion on that warning before?
>> 
>> I don't think there has been a discussion around -Wstring-compare
>> before. Unfortunately, it seems like clang's -Wstring-compare is
>> different from GCC's -Wstring-compare. clang's is basically a subwarning
>> in GCC's -Waddress and GCC's -Wstring-compare does not really have an
>> equivalent in clang proper (it seems like it might be a clang-tidy
>> check IIUC?):

It's unfortunate that they do different things, but both warnings
seem useful to me. I certainly wouldn't turn it off after a single
false-positive.

      Arnd
