Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA524E4A8;
	Sun,  3 May 2026 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777806412; cv=none; b=d8UsmgNC2tlVLmJ79jyZxpCpsFyCKbhcaallPFiSwhTqZ+P7OCbKqnbjoBootKl4p8AVo9VpvxtL7wVlmuopDQi+c/CFU7lpEgo9xdpzMboV3RxdJfoThufLvbkeCAEiC6ZBwARPNhAl1SCO73bvsaM6CuKvtIvaEIe5rZ1h83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777806412; c=relaxed/simple;
	bh=YQOeN5BLc+pPy9v92y0mrqvir0VtBXLhse/m+6gpt68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=on7TpUt3z1ZxJieQz89rfhCsroR3tZTv4n0mneH5oijQmnsF0R2pEsxKPPnibX5pJKiC0gNTOQJ2ewBVNBE6gfW0gguXBdhf34IwPHBE6hrXruKwkHcisxp1SSPw/+GDTURoJfHyrzo2m957mh36geTYcU5G9Xr7CFeKhL4jsNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY0hxcxN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY0hxcxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CDBC2BCB4;
	Sun,  3 May 2026 11:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777806411;
	bh=YQOeN5BLc+pPy9v92y0mrqvir0VtBXLhse/m+6gpt68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sY0hxcxN2yrN+m4OPBZeYw7pWttaE94uan/AjdsPJ22WWMqj9w+YEXvNrBN2YghwE
	 cJif5MIeR+0k7UfKSilTVqQhmEJUMrx+fb0GwFHigphtEtCBViuKon7aTuj1jPnCsz
	 TxrwxKcvkMXboPsYcpBKrWuVSAZaBLUdMfR7Kffaa/QYtuxzBhCETgsZC51q3kD9WD
	 xodr5pu/pX/B4QQknUmOuKJawGk9ol3G4gpmuMcDVidKp7AVgweAX93PJFAG2Ezjty
	 CUWvVeyxRci7R8KJuv4D8Avt2l7290SzMvkXgoTNe59gXbsOSoM/CMpwUP51m8Mqxf
	 o5PliNtcqHYnw==
From: William Breathitt Gray <wbg@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Lee Jones <lee@kernel.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	kernel@collabora.com,
	Jonas Karlman <jonas@kwiboo.se>,
	Alexey Charkov <alchark@gmail.com>,
	linux-rockchip@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v5 4/6] counter: Add rockchip-pwm-capture driver
Date: Sun,  3 May 2026 20:06:43 +0900
Message-ID: <20260503110644.462016-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <q0kG3ZZyT92lQlYsvZD_qg@collabora.com>
References: <q0kG3ZZyT92lQlYsvZD_qg@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=wbg@kernel.org; h=from:subject; bh=YQOeN5BLc+pPy9v92y0mrqvir0VtBXLhse/m+6gpt68=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJnfdXSjr+uG9LolLH+69rEAp8L++Qpsv/iEOfd9/7FYO 2LLJdsNHaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBE0l8xMnTNE9hydJfidDbB cPdjUssKRfzfqV9z5XlTyWx3+odinREjwyLnzQ2Vefe9l7o67xPmtlsRfTpUcf3xbRJmKg/1F7m vYgYA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Mon, Apr 27, 2026 at 07:35:32PM +0200, Nicolas Frattaroli wrote:
> On Sunday, 26 April 2026 12:55:20 Central European Summer Time Damon Ding wrote:
> > BTW: Is there any user-space test tool similar to libpwm for the
> > counter subsystem?
> 
> I've tried looking for this as well, and couldn't find anything. If
> it exists then adding a mention of it to generic-counter.rst would
> be in order I think.

Fabrice Gasnier added a Counter chrdev userspace test application to
watch Counter events; it's at tools/counter/counter_watch_events.c if
you are interested in trying it out.

I do need to update generic-counter.rst to add a few new things we've
picked up over the years, so it is on my general to-do list.

William Breathitt Gray
