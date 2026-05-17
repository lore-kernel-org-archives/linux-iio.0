Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93249391837;
	Sun, 17 May 2026 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779023462; cv=none; b=SwnDGxjvkwGjVVVWrX7dfTFHTRRh3ltUhLra5FcdcKFK8CIGSTUCdR1W2AYPSm8ZMs/SWNyQmwQz7N62fDQsQ+5qR7k+OBo1PXZwFb34Eomz09vEX6vP03Ef4HK/vFDFk70oKdjRwusEf47lkS0LtmhcvSr2yr9Lsf/gyshKX+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779023462; c=relaxed/simple;
	bh=Pl0ntdz5RoEzLeLIVajFgue9u5KyRkR49SApKaEd1T0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZsk3TAN6BTIWCFeEEjugMtOvgFziaCL0itKDq2rX1ATQOtKVVikQECeH155pjr5qS1caoowpeVOqkNRdzVoS4voTwka5LIN5ktbL7dbxJJR8YldkZkVdFsl7/ScLRA6/5e4aWy2S6Ss51Md8uZOfyr0SKSkj98Ax4s4Iq8Q+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBkTOAOk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBkTOAOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB09C2BCB0;
	Sun, 17 May 2026 13:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779023462;
	bh=Pl0ntdz5RoEzLeLIVajFgue9u5KyRkR49SApKaEd1T0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JBkTOAOkOTae8Y3MeAx9p8Sj8wx+NZnVDSC97DmjVC0m6ekxlqFSV/epgq8NlhmLy
	 BnJQntzmiRJLcf89cafQP12hlhWLrwiK0vNSpkRQckxuegoqab3hXZqntJgLIhNUTH
	 QlNLLkKud3d509Lyok3WyCLc/X2pl9CLfFy7HYkDIaFbIKLqCPdSO5rqm1LXgrmclk
	 yURjs9Ah3F06qzuUwqUW1U+FTz6n57P05DGZtUybRvCgxOn2HB4+gvg/q5+3Eenq8b
	 LUJQDIPS4zuYN0L5T+8F1aRVWqAesjnAaLbbKltWUKQrBuBqPB+te/qlsuao65119v
	 kUS8KsQvc3lIQ==
Date: Sun, 17 May 2026 14:10:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: veml3328: add devicetree binding for
 new sensor
Message-ID: <20260517141054.3981672c@jic23-huawei>
In-Reply-To: <20260516-veml3328-v1-1-1d4b663e2fe3@gmail.com>
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
	<20260516-veml3328-v1-1-1d4b663e2fe3@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 23:50:53 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Add devicetree binding for the Vishay VEML3328 RGB/IR light sensor
> connected via I2C (SMBus compatible).
> 
> Additionally, add an entry in MAINTAINERS.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

This is very standard looking. Have you considered if any similar
bindings can be easily extended to cover this device?

Note that there is no direct relationship between bindings and
drivers, there are single bindings with multiple associated drivers
and multiple bindings covered by a single driver.
Also dt-bindings get used in multiple projects and some of those
will do different splits in what code covers what parts.

Jonathan

