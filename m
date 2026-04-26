Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A3364E92;
	Sun, 26 Apr 2026 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214663; cv=none; b=oKIX1kVi98dXh7Y+cUBxDStuHlXv5kfZ0UJwdpFs7yy3SHHaXnE6IepoydMIhgrIn5Zq1Q5S39UrcUbUsuOGMPlbQg/K19LQhbVt1M7wlc+lPkRX0lUPJaAYBf7/RGSKABCsKveHJuZBur1cIvte4n/j6GwpzarLaLmTfJj9ogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214663; c=relaxed/simple;
	bh=e+xPsl4A1cpUAx2yaL0IhjHG7gsH4KjV7dGT04rVRnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiHYX7rL0P4LDxkCvStskQGkHpl9l3uuzKi9t/wEGTi8WTykKe6Til35a96yRDWmT11y/ZE7GodNXdLViRLZocH8dj9I7WjRX5rTdtZ3ygAu2aEZ2HcpnqVvyzS5oD64b8ZSNTGwHq/xrUU4ViIj+AjGRuDsZU3JABrCbs0UoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifeb5TE1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifeb5TE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1916C2BCAF;
	Sun, 26 Apr 2026 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777214663;
	bh=e+xPsl4A1cpUAx2yaL0IhjHG7gsH4KjV7dGT04rVRnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ifeb5TE19hN2XmAp/k0s2C+kR0fpbJZpGWGIkMMLYT77SEBVX9KiyWNIz6hvUCEWp
	 eaUl75rxicqTHEgTG85bJstkx72naPBGMI2OC9tIjEZAroUGsKxOwNX8RDSXcZrkVW
	 GtOitQQzgjd+it/wwR6arLHiQk+rAauv+aGucuUQspx1hnnsf1P/XoCDRjITrgvns1
	 QFYZWx/ZRg9hyAr31Uxn9RjRoZLjzMuoyOvBrBQd9cidaKlQsOjbW9KlWlkNtXxUGz
	 xM9bjC9pEfEcgvyWE2pkDs9bMy3HlQBiMRB9EIUjv1KL8LfPgi+1ExpDHBeeSBX1h9
	 1p2xKCoBvKBTg==
Date: Sun, 26 Apr 2026 15:44:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>, Brian
 Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/3] iio: imu: inv_mpu6050: control vdd supply using
 devm-helpers
Message-ID: <20260426154414.2130f5da@jic23-huawei>
In-Reply-To: <20260426112334.3938774-4-andrej.skvortzov@gmail.com>
References: <20260426112334.3938774-1-andrej.skvortzov@gmail.com>
	<20260426112334.3938774-4-andrej.skvortzov@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 14:23:34 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

> vdd supply will be automatically disabled on error condition during a
> probe and on driver cleanup.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
Looks good to me.
