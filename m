Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC1346E47;
	Mon,  8 Jun 2026 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935291; cv=none; b=ivTVHSkWM9FnsD62g5x/RuwO7d3JOqFjctnRts6kwd3TOMWDAzYLr0PYP9vIy9LOXDZhmwjgb/wJhL9fZ1gU3oP3OEqdX1IEX2iQKzibsC4s4JlTOinOT/OzkPO7qOf4/v6ZTqc1zP13p8MKNceKCR4gihiJiAqtJLpAgiS9NQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935291; c=relaxed/simple;
	bh=B8hgE4M7eXI7kSmC4eghMQkY6CackfUHmBQthp3sLAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKZeIISErhOqTrySn7JBbkqvgf3lk6W+wWkz+LU02xdArZqYGucsSIFmdy6Ij1lHcI6+TNd668rLOq8YhhvAXqM/Eki+6vSiVugIWy0/DnGh4jayNCK+pKHfTircdNPsg7ACHelvdUiWTbtuXxe3rp+Qjbrs4QKYrNopb10+YBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bdc7zB/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bdc7zB/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692741F00898;
	Mon,  8 Jun 2026 16:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780935290;
	bh=mklMJSdWkBcjZ9kQWelFLY3RhwE/PmXneAVMlDoJGOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bdc7zB/ixMQZL1yv7wGg9roiG0FPPLJzvP/rh8NIqMr55fATCURLYg//nWUrfflZC
	 LYA6qaqMCc6ILAfxwZTX5JQWFC+ACEaVl5RrJfLS99XAiJkO26Uu6ojkuunaHE/Y3x
	 K45/+8w994ziUNie/F6cuVl1vbdRdZ0zu60SvCCNfDlupR2JkEg84p9KN3dJSiT5IR
	 Z2bQ3B33POGNdbHweroy+Z3Rh34/Av7f44RvzCxeleNAP7NBvyedN7NIYCD/+xVDKh
	 X64oGMtDm6Bh3FVQ/G9iwOyXykgysmS0cD2tQYq34h2c9FPPk+2W8TYvG5BI+qGInd
	 NNAearBd3Fcfg==
From: William Breathitt Gray <wbg@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] counter: add GPIO-based counter driver
Date: Tue,  9 Jun 2026 01:14:39 +0900
Message-ID: <20260608161440.1172602-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-gpio-counter-v5-ping-wafgo01@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=649; i=wbg@kernel.org; h=from:subject; bh=B8hgE4M7eXI7kSmC4eghMQkY6CackfUHmBQthp3sLAo=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFlqrxyLdZ+vq66q/rPC60TAhs+H4vfdDPzjHP9k25J6j r67qZOTO0pZGMS4GGTFFFl6zc/efXBJVePHi/nbYOawMoEMYeDiFICJ2Fgx/C+dpRufGOUyO6Xt 8QaV/zs5vvTqXFi360/yn91dgmsEi/4y/GZzPXRKoVpQNcFRKyXuwa8Nxs0zTwYqTHh96yTHNW7 5JUwA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Mon, Jun 08, 2026 at 02:19:32PM +0200, Wadim Mueller wrote:
> On Sun, 24 May 2026 21:38:43 +0200
> Wadim Mueller <wafgo01@gmail.com> wrote:
> 
> > Add a binding for a generic GPIO-based counter.
> 
> Hi William,
> 
> gentle ping on v5 - it should address all your v4 feedback, and Conor has
> acked the binding [1]. Anything still open?
> 
> Thanks,
> Wadim
> 
> [1] https://lore.kernel.org/all/20260525-register-bogus-b198545b69a8@spud/

Hi Wadim,

Sorry to keep you waiting. I'm still working on the review for v5, but I
should have it complete by the end of this weekend if not sooner.

Thanks,

William Breathitt Gray
