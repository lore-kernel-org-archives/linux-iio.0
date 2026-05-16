Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5423ABBF;
	Sat, 16 May 2026 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778943745; cv=none; b=fc5xEJWkV+1dGbZlmu+PefVR/zoDGtQqRKfQtgVqP23zw1VjhjCd+vaRfQaPIrBukYW4AcwXmGJS8kuEy+8F2nbt5jYUkeAtR8YGXteIhSvThbgM6Zm+1Lm4wOcoNzZck+nT7RlDiQSSwOrWiMENPgWDHVTAFSJ/0HrpDs7Wwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778943745; c=relaxed/simple;
	bh=uc8pZ4p+HwdI9bwVDTtSCog/2rGBEMcyxeIJvxFLqKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrnB3liPh8Nw01m8worjfgGTW72Bus+8WnLbcoPKV8z4aThJay4aP52wTfiK1yO+zeSf7TSN1xFaSgo45txppffT37slItIJMad4oMr7TT/l9leI+9TBXwuDpk0LPDvhT6r+LsSilfIACFsLt/iFolMZnQLRxMxBH7sUzM7BnF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exSx/OhI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exSx/OhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55381C19425;
	Sat, 16 May 2026 15:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778943745;
	bh=uc8pZ4p+HwdI9bwVDTtSCog/2rGBEMcyxeIJvxFLqKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=exSx/OhIyTzM9AqPgq7wewrwJhVB+w3pV+CxqRz0jsxhbIK6BF8G08y6vJsdpQfBs
	 4syRzHoi5Iqj/QlpaAUizegO248cw4Xf8ZE9Z7Cgudw+crIGv73BQuPZCoYsDryViZ
	 Wbc5iYvFKOqOSbxm8GQyLN0q7NvKEDnjMcc6oieQ0Ux8nkITOAhcpKkLDrSDTspOi2
	 uLoIzGQgFK7l4sMN3gVGS90Bc6xKbOHsnlrF0rPRT190nWEjetS6wk64kbSdUHM4h9
	 oG1oahV4q/EDroF+ns8oh7yWSpX3tUFDDRP1oz3AA3UfgZ0NvwKGGPzTduvl6jPI9X
	 WbCUNUpYMhGfA==
Date: Sat, 16 May 2026 16:02:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michal Piekos <michal.piekos@mmpsystems.pl>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Maksim
 Kiselev <bigunclemax@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: sun20i-gpadc: add A523 gpadc support
Message-ID: <20260516160214.658b5543@jic23-huawei>
In-Reply-To: <20260516-sunxi-a523-gpadc-v3-2-a3a04cff2620@mmpsystems.pl>
References: <20260516-sunxi-a523-gpadc-v3-0-a3a04cff2620@mmpsystems.pl>
	<20260516-sunxi-a523-gpadc-v3-2-a3a04cff2620@mmpsystems.pl>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 07:34:15 +0200
Michal Piekos <michal.piekos@mmpsystems.pl> wrote:

> A523 differs from existing sun20i-gpadc-iio by having two clocks; bus
> clock and module clock.
> 
> Change driver to enable all clocks.
> 
> Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
Applied patches 1 and 2 to the testing branch of iio.git.

Given some other folk were involved in reviewing earlier versions I'm fine
adding tags for nor next few days (or dropping it if I missed anything!)

Thanks

Jonathan
