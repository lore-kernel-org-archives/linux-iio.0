Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112EC45C712;
	Wed, 29 Jul 2026 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341543; cv=none; b=S4VobKnLgHlJlRcivJsnSmylH1TjrtvHyC+ngAKtfZmYvjMR4GHOBhe7zq1EbXbQpH1b13RNcvinl1xKhohBvNwgANZpY1dEy0w/9CFMz+taRiDuYbZUAeBWT0uGKULVIpTTRz2eQgTCfN3Y5P4pkT/nnxvrWPVXmhd9e0Jbbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341543; c=relaxed/simple;
	bh=ntyZ1m2LlvrSpP2vZZLM+07t8QOVl2iUUB6O7kMIuZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dwx7Kvy7OYh5cW/i5nkZlj/qvEJY87yq3WUCqjOR7oL/1DmVA8c4mCQDQlKMZPqz8QKYVnhkSJYV2ceo84CFQb1tN368aF2ahwEUgdekM3fUKumIbCJlOC4xzP58JDSxKwxmHxuKr6nrkCtqN2KZqWMMQQwl8dwhn4t2I3FIrEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3h+KFhl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3h+KFhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF681F00A3A;
	Wed, 29 Jul 2026 16:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785341541;
	bh=6Q0+TxYLzL7dd9PwATR9DjrXtp87mW2+VdkbJE0raBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K3h+KFhlzmumrgO0Q2SLoOxovx5oiZ8DEksZY7j8MLIXIejmkbXO2jCLClOJ3rjgM
	 vWAEZ4YzIyrRjqB/K7nlTlgbutNF5w/1VB/NP9lE2eJYVuQBPbHStW+nuxca782jjR
	 Q2btb1ilWqQ4oxMQnRD57lRzJMWlEjfyJJDXum+cMmtNsuY/9y5q7EBxZoAHKyOpb2
	 nK6+nWevoixQ4ftUergg6XXg4xqH84qVNKI/T/zTk8g0H/bIEHl25B1CZPFKxQv6k3
	 YCqEhmtiWPf0TBQRMsEB1CC0yptLsiKr417sCnRp6PQX/K0+DdKHMjtEvMcn+gv2/P
	 ze6FDSvwqfJEg==
From: William Breathitt Gray <wbg@kernel.org>
To: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix DT channel validation
Date: Thu, 30 Jul 2026 01:12:10 +0900
Message-ID: <20260729161212.1296687-1-wbg@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729054102.7-1-bbnpreetsingh@gmail.com>
References: <20260729054102.7-1-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=674; i=wbg@kernel.org; h=from:subject; bh=ntyZ1m2LlvrSpP2vZZLM+07t8QOVl2iUUB6O7kMIuZU=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFlZaq49C9ZMLtkcrH2n5fnPRUKrd/2bH90VKpenNbuou fHqVZ+PHaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBEvrkzMvzM23y8XfHz/IMG 3hP6GN6s9N+/yfna8iMzz/7mOst76LsCI8Mh3121Z5/rB194L/3T+Sa3xjpPsbiEso9nKm/8DP8 7PYcJAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Wed, Jul 29, 2026 at 05:41:02AM +0000, Babanpreet Singh wrote:
> Hi William,
> 
> A gentle ping on this one - it has been a couple of weeks without any
> comments, and I could not find a competing fix on the list or in
> linux-next.
> 
> No urgency from my side; I mainly want to check the patch has not simply
> been missed. Happy to respin if you would prefer a different shape, or to
> drop it if you would rather leave the validation as it is.
> 
> For convenience:
> https://lore.kernel.org/all/20260714042910.7-1-bbnpreetsingh@gmail.com/
> 
> Thanks,
> Baban

This patch looks sensible. Do you have any objections Kamel?

William Breathitt Gray
