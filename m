Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55427134CF;
	Mon,  9 Feb 2026 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661480; cv=none; b=BnKZzkb5RoNf/AJAWHNtkJRRB68o2tdanrBgBswADPX9hpXE9QJS4w/XEU6xtdxjNwBr7ckXc0wRYlZtvMUM9h8o5A3WsLszjtYyWldPh2rTbS6JaAPo5/Ouh1VfSi4p5Wk3c2YVAvC932XVJeZSJ3aDNnJdInt+DKWJpcM6mEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661480; c=relaxed/simple;
	bh=teCIQL1B+FcantvtJtxCOxoGHWBxuefGxsv13LO4zP0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMw+a8aLhDOt7aisefZwFwmq/OXMIkcoANVYWWYxqCs9joQwN94gEfBdLL/Rprtl0slE6SSYOol0ZiFzh2JsHnzaFfkfi6lPTMYVT7KSzzSg6cWOrSasOiBizH9FZCzuj4xy71yu7uia8vVJ1NNVfiEphNfV5+W7duRPVPBCafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f8tP70mznzJ46Dq;
	Tue, 10 Feb 2026 02:23:39 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B1CB940570;
	Tue, 10 Feb 2026 02:24:36 +0800 (CST)
Received: from localhost (10.48.156.2) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Feb
 2026 18:24:35 +0000
Date: Mon, 9 Feb 2026 18:24:32 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kevin Tsai
	<ktsai@capellamicro.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] iio: light: Add support for Capella cm36686 and
 cm36672p sensors
Message-ID: <20260209182432.00006c3c@huawei.com>
In-Reply-To: <73ec81de-86f8-477c-a5ca-aae83528dfab@gmail.com>
References: <20260209-cm36686-v2-0-a48126d2b124@gmail.com>
	<aYoBwFW4ZDFhmlvy@smile.fi.intel.com>
	<aYoCJMlaaPO8auIm@smile.fi.intel.com>
	<73ec81de-86f8-477c-a5ca-aae83528dfab@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 9 Feb 2026 20:20:07 +0200
Erikas Bitovtas <xerikasxx@gmail.com> wrote:

> On 2/9/26 5:49 PM, Andy Shevchenko wrote:
> > On Mon, Feb 09, 2026 at 05:48:22PM +0200, Andy Shevchenko wrote:  
> >> On Mon, Feb 09, 2026 at 04:23:40PM +0200, Erikas Bitovtas wrote:  
> >>> This patch series adds support for Capella cm36686 and cm36672p ambient
> >>> light and proximity sensors.
> >>>
> >>> Capella cm36686 is a combined ambient light and proximity sensor with
> >>> adjustable integration time, interrupt and hysteresis support. It has
> >>> the slave address of 0x60. cm36672p is fully compatible with cm36686,
> >>> except that it is a proximity-only sensor.  
> >>
> >> So, can we share the code (assuming there is a driver and it already
> >> uses or may be converted to regmap APIs)?  
> > 
> > Ah, it's being added with the same driver... So, have you checked if there is
> > any similar HW with the available driver in upstream?
> >   
> 
> I checked only for other Capella sensors, I forgot that Vishay acquired Capella
> Microsystems. Now that I checked, vcnl4040 uses the same registers and regfields
> as cm36686 and can be used instead...
> I am sorry for wasting your time. Should I add a fallback to vcnl4040's
> devicetree schema and add cm36672p support by excluding the light channels instead?
> 

Sounds good to me.

Jonathan

> 

