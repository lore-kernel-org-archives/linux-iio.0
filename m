Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9150410D15
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482044; cv=none; b=Wkwzi7XLDb5/3fpFmr17g1XJbuxY5Ew+dGARYxyp3We/8M3JJkqJwFVTkId4SKl84VIHfMThH7X0wdPWTUaj3GH54mQLIcpf5PIXSPgx38d5cRcg4omjVYxvXDDgmNdkCJ998QBaSykXP2hMoJ7exZdi1Hq7P8K3iVtjaDQMlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482044; c=relaxed/simple;
	bh=WhFcs3kkuFcE52cYfShtxn0Cj52Hji3syuWbbz9Kqy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z67aDvBV5DMDyYiVPHgwh1Wl8HgQ+YYabs3r7Ars6M3/xEs/BwXK0P6+vWSo4ac57lXapdt3xXI6hyAr1fuXGIz9Ns4FnYjYuhkwbR+cyqPvExPfeGAvMIFLiduOlktBelNizBuq8CLNiulVPQh7ZS1loP0/4qvOcyymQg+QZ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FxvtFvUn; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FxvtFvUn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777482030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMXTsNbmksKzy0POEDzynJHlLKIXPoW6tJs29Bt4mOY=;
	b=FxvtFvUnzUf1Z+VN4yVw4R15f/ek+ReUn3ep6xwgw/+Se4Le1Qp7N4QZUDl7COB58eAdIw
	7XJ7hPkzGoQJSIdA2zZTBkthmTQ26ldbTGYCrpuobvlmwlgZxr/3Q/gOhT6addZfWRooZY
	o3CjCqGkFxb4bXfYYmOriVfi/UmzTXk=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,  Felix Gu <ustc.gu@gmail.com>,
  David Lechner <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,
  Andy Shevchenko <andy@kernel.org>,  Lars-Peter Clausen <lars@metafoo.de>,
  Arnaud Pouliquen <arnaud.pouliquen@st.com>,  Mark Brown
 <broonie@kernel.org>,  linux-iio@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hw-consumer: fix use-after-free in error path
In-Reply-To: <afGs4jBXEMWDMFbE@ashevche-desk.local> (Andy Shevchenko's message
	of "Wed, 29 Apr 2026 10:01:54 +0300")
References: <20260428192636.58e4fc8b@jic23-huawei>
	<DC73DE77-89A2-4268-B07B-2CED5C1D7592@linux.dev>
	<afGs4jBXEMWDMFbE@ashevche-desk.local>
Date: Wed, 29 Apr 2026 17:00:08 +0000
Message-ID: <7ia4qznx1z3b.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Andy Shevchenko <andriy.shevchenko@intel.com> writes:

> On Tue, Apr 28, 2026 at 11:34:22AM -0700, Roman Gushchin wrote:
>> > On Apr 28, 2026, at 11:26=E2=80=AFAM, Jonathan Cameron <jic23@kernel.o=
rg> wrote:
>> > On Tue, 28 Apr 2026 18:59:28 +0300
>> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> ...
>
>> >> I am also wondering should we put Reported-by with the reference to A=
I somehow?
>> >> Jonathan, others, what are your opinions?
>> >=20
>> > Would be nice to do so for these - things noticed whilst reviewing a p=
atch
>> > type reports.
>> >=20
>> > Roman (+CC), any suggestions on how to do this?
>>=20
>> I appreciate when people are recognizing Sashiko, but I don=E2=80=99t ha=
ve any strong
>> preference.  Many engineers are using it locally before sending patches
>> upstream, so we=E2=80=99ll never know it anyway. But Reported-by/Assiste=
d-by tags are
>> appreciated when appropriate.
>
> The problem is what to put to Reported-by as an email. For example LKP bo=
t or
> syzbot have dedicated emails for that. What about Sashiko?

We have sashiko-bot@kernel.org !

>
> P.S.
> An offtopic, how can I be email notified on the reviews done by Sashiko a=
gainst
> my patches sent to Linux kernel project (mailing lists)? If you can add me
> as andy@kernel.org, I appreciate that!

I don't have a personal opt-in at the moment, it's configurable per
mailing list. The current configuration is here:
https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_policy.t=
oml

I generally rely on the consensus decision by corresponding maintainers.

Thanks!
