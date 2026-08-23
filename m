Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CEF4AEEF;
	Sun, 23 Aug 2026 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787444969; cv=none; b=tuawJCoWhHSpbdbgb1GmzS4IZxVSXDihnXUehqbGLmS6qRR2hucxnnvh+LEmDb7/52pt1WjPN7UICcUW4FVTrETGhdg5D7m3/igjEalbEMJPaFP8VTtPqG914yiJl0w627CUy4REa1cnxyUJrom6jN75mp8OpaBCDfC2R6v8Co0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787444969; c=relaxed/simple;
	bh=3gm+17AAM3DITaDSJXBuA5Wga4hb/mr/tYfT4eQAdLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icAEiyo0tagbz0i9OqBc6uFx0YXy2WNxRqbt4U6kYHasPQd9R7oUPGJMUxWnWaIkcuHsRNTPZ26U8UfIhz4JSWVHDXxoUi0qulK6KrRuovfKpWMow/5XzramU5TF+GxBBS7yKEfU+aC+Ve9lF5JJ3G1KZMXO2o6Os3bPJSS2emc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcdAy7MZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcdAy7MZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754801F000E9;
	Sun, 23 Aug 2026 00:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787444967;
	bh=7UY5n9qQPMGMnnRq7U6pqxvxu6lugc3HJYg0BucsmBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hcdAy7MZ16ZMIIP93Q+SdTjJYU+wsC0I3uDk+diENz16+FqtbuCgzStwnKYAwJRrD
	 lRGhrdFuaKQkMkmrZ0gFaemUIsi8RNg0MbNdhw/irVwIF6xY3aneUVokBjws4/NU9X
	 ChHQDEOS83eCFMo6KtcZseVi0nO0xXyXLA+dakTn7DulYfoKIjPultfURE0LrNteEw
	 slUHhvL+5hIQXGicJqxPeX0DNpMSgwMU/WZmROq53nuyr9yiB8upW6Nef0rL1uG22J
	 ExxWJ3Ok6u5c4edIa36NIpI168ngKz+YZukQvemkMbXAYboVXFSFhbYlec8doZ+6as
	 d2myIe8PVpAeA==
Date: Sun, 23 Aug 2026 01:29:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, Sean Nyekjaer
 <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH RESEND v5 0/6] io: accel: mma8452: Allow open drain
 interrupt pin configuration
Message-ID: <20260823012922.22bdb16e@jic23-huawei>
In-Reply-To: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
References: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 10:15:27 +0200
Esben Haabendal <esben@geanix.com> wrote:

> This is a resend of v5 which was not fully sent first time for some unknown
> reason.
> 
> Extend the mma8452 driver with support for configuration of the
> interrupt line in open-drain mode, which is needed for hardware designs
> where the interrupt line is shared with other chips.
> 
> Adding drive-open-drain property to mma8452 device-tree node for such
> designs to enable switching pin configuration to open-drain mode.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
Hi Esben,

Just quick not to say I took another look and didn't find anything to add.

Looking forward to v6! 

Jonathan
