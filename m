Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520F3191BB;
	Tue,  7 Apr 2026 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589733; cv=none; b=QO+b0GKm6qBk7ZjqYoB443le0auwUTymHkNKH1E4Em0VGxmEHdw61H8Z9YNay+DR8QxUeXj2ua/WKe6xeJS5x0R0bX25VYonH3tThPHstgj4dL3LIl7zZF+kPVaNULrkNnq09j+mjdzhjKdb4UvHowv9EmrfUz1lxSTOuUGwlxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589733; c=relaxed/simple;
	bh=EG+qL4ZeWA4xgmEUZXqNF+tVCYs/Hf7pe6gP6h7a59o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaX3saBdyYfC0KPj2zVD89tH2H8yQLrJflfr6vdpkRCDyfmEEAgc3Mgz5pFSHUWgZfgXg+ifa5jxr7wa6EArJ2qbxXJeZhlxyEnyM5L3Ke8fWzMToyWUCEFNWSXFkWzV2STH6lXCdZ3NJet4h7OueVU81VnA9s2bOVtHQxRkEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlEqGvy4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlEqGvy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E5EC116C6;
	Tue,  7 Apr 2026 19:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775589732;
	bh=EG+qL4ZeWA4xgmEUZXqNF+tVCYs/Hf7pe6gP6h7a59o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlEqGvy4kixGUmA2/aaoGYifZqCb4nxTZcm0SoQALBD2Ki1BMP2g45cg8TNv4/x4E
	 ChUdYqeu44QmMbUHKs3ew3BHpoEI1rjzFiD3N0rKpzUixA7rSiC+EUkSca763f/Cju
	 +qmuwaTAUpAeF4bq0wbWtHkV12jvlOVl4yHM3CGpcsPvusQAZAbltLBdm7favrSSQF
	 NpNIMZvoJ+NNaLGRazuo1ZyhqckUmn4HIR7Z/XGlowPGEqLyjEZlprx8U7PkEuwDNR
	 R7hrYV5OZ3UXESi6/6Xu6YFZZruEwuPN/Y8joVDUlyku1x0WfjiyzEk8B2MIaFhHC7
	 7hxlNQocrrAuw==
Date: Tue, 7 Apr 2026 14:22:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-renesas-soc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 07/11] dt-bindings: timer: renesas,rz-mtu3: move required
 resets to conditional
Message-ID: <177558973027.3526539.2515277237101230576.robh@kernel.org>
References: <20260327192425.438263-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260327192425.438263-8-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327192425.438263-8-cosmin-gabriel.tanislav.xa@renesas.com>


On Fri, 27 Mar 2026 21:24:21 +0200, Cosmin Tanislav wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs do not have a
> reset line for the MTU3 block.
> 
> Prepare for adding support for them by moving the required reset into a
> conditional matching all compatibles except the fallback one.
> 
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>  .../devicetree/bindings/timer/renesas,rz-mtu3.yaml | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

