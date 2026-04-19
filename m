Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E441E8320;
	Sun, 19 Apr 2026 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776588144; cv=none; b=lF9GO+r9f1Pcas0elv+tqX+Dux3jW21KU3N1fn6OBhXmW5+c1W8+lAwVOEZ+dcOxuJFbBVUNhIZQbyaQ4Hb+4ca7uHA/VftA1MlGStRc0Ugt2YyO1bgfEg/RQs68fzSHwtLH5YcEgAHAV65x1cCcB3QddW9dW0sA/5gJmpWtOag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776588144; c=relaxed/simple;
	bh=MOL7VmBpAWH10DRxbdQF2yMii79Js7aAazFeqba1Et4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRvwaz0vBPBTP0jDWb+mfRwb/oifG+1CYsGItEmo7F3pU8fiOiSE/Z1x759SRGpNPItDU5xcvGrb/jUxmfrJRcwL94YMywb/fiWcEREHiVMDVnd5+GWxKtSsZwbI2OzFSjXVYpYxakwVtKvyjAoj8gMo+SMcqjCBCexHz9PkI5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i7/XB3Wu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i7/XB3Wu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89FAC2BCAF;
	Sun, 19 Apr 2026 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776588143;
	bh=MOL7VmBpAWH10DRxbdQF2yMii79Js7aAazFeqba1Et4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7/XB3Wuf5bSTDFleMu2lB3nxGebqJLARqhfemi8uIbNA0+d/wqmW8+zCYzIFyTiB
	 7tvX0TYAzP3GkqLcV2cxDE1h9sD1MloIyaFvUftuYwabUL1Nf1rq++yYhQtk/Mvp5u
	 HNqQ+aC1HQwFUz/xcZs6SQnGS5DWHlB71U5+906M=
Date: Sun, 19 Apr 2026 10:42:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] misc: Remove old APDS990x driver
Message-ID: <2026041913-coziness-fragrant-74ad@gregkh>
References: <20260419083125.35572-1-clamor95@gmail.com>
 <20260419083125.35572-4-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419083125.35572-4-clamor95@gmail.com>

On Sun, Apr 19, 2026 at 11:31:24AM +0300, Svyatoslav Ryhel wrote:
> The Avago APDS9900/9901 ALS/Proximity sensor is now supported by tsl2772
> IIO driver so there is no need to keep this old implementation. Remove it.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  Documentation/misc-devices/apds990x.rst |  128 ---
>  drivers/misc/Kconfig                    |   10 -
>  drivers/misc/Makefile                   |    1 -
>  drivers/misc/apds990x.c                 | 1284 -----------------------
>  include/linux/platform_data/apds990x.h  |   65 --
>  5 files changed, 1488 deletions(-)
>  delete mode 100644 Documentation/misc-devices/apds990x.rst
>  delete mode 100644 drivers/misc/apds990x.c
>  delete mode 100644 include/linux/platform_data/apds990x.h

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
