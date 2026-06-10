Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366040D567;
	Wed, 10 Jun 2026 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082650; cv=none; b=RcI3wg/SBjv3Vv2o7cjpDQ6DU1pU9whv6Iyb5B1E3qK1IdkfXNJ+6I8LCz+GDA2f0Z2CNsO4m8NaJC2auc3PWVSylkjUYBBw/WfWtCP88Zi2X622wIA739heKNncIeh9IX2GLOxhsE/pIK6T03JK1AcKS/Qzm2pv69RoZQjSLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082650; c=relaxed/simple;
	bh=jmGnU31rnzSYSXnwKpzH1l48Mfh7V4bzSDCW5RSUDJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va/VJn21MafaioNk46ibkd/6hAuwRPHCBZDsi3dYZfs+hUyXvaRsxZlSrScjcqZEdYYqALMqI1qRbwJhgMhhyztFIBsVyyzMyzdULz/G+f6HpwR8w8t0n07EPlv0tHsMq1gpbqyfQLQVR/wIko8DMpjl5H29iChyryoxeTVlv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF78ithT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF78ithT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92211F00898;
	Wed, 10 Jun 2026 09:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781082648;
	bh=jmGnU31rnzSYSXnwKpzH1l48Mfh7V4bzSDCW5RSUDJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nF78ithTpjFdj+qxBpWsFyWYA+8z1kbkCU9EowR+VE5tVsa78RmS+OCY4PHQ0tHNF
	 evegwLofTWtycLQy0ES+/lNr5rc+TAJG9fOolW4muxG/b30+A5oRGrI3uigNkGAZlb
	 pnXjdaWdT8L4EE4ock96dVWfPPgshNaol2FPSmvrS5dW59ip9QXuMiicn5ehbn83Ov
	 uQ08ZB0P7fOlDY9W2qjlbZcUHzBbvXlMJBFSTBiyu+UoPQIugmGAREhM+GCEmDdKjb
	 jSnQ/ZyxDXzgwmCT9yXgKjav0Ew/8w6p/udiASeU8nAVbq/8AbAEgTIX+ITmERiKuO
	 OBrSJOloGxpgg==
Date: Wed, 10 Jun 2026 11:10:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as maintainer for SPS30
Message-ID: <20260610-turquoise-marmot-of-research-c3c51c@quoll>
References: <20260609161701.52513-2-m32285159@gmail.com>
 <20260609161701.52513-4-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609161701.52513-4-m32285159@gmail.com>

On Tue, Jun 09, 2026 at 11:17:01AM -0500, Maxwell Doose wrote:
> Tomasz's entry is no longer valid, as he is not active anymore. Add
> myself as maintainer of the SPS30 to replace his entry.

Same comments.

Best regards,
Krzysztof

