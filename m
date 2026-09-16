Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718E53E0230;
	Wed, 16 Sep 2026 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581520; cv=none; b=GymrCQCT8dpRWHEzsCZeRBS2MzK2tFukKMHj6jGs6qHBT+u79aBIYxP0u2LCTEkK8syAWtmzIZ73xtoqQ8ik6fscoztoObDJC9XnLf6S3mMsasL8nLDKlLvRReKsl3WyMajt+1w7DA7C2dGH0fzJH/Fl3PmVO+tpONawLQ5HW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581520; c=relaxed/simple;
	bh=Ix5YQbxRiGApJbi55zHSXoDtwcQg5K41CTNAs1PkJAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHw2oPSa7I1Pm6SoBzdsAJ11TMFyZ2Ig3pP9yz371aH4A+F34XBcoooJufpKNAEw75ryRojBl1gr2UqqE9jwHi5IbxN4TdpyIF31Gw7gdriwMyju8fR1GfRGeDq+nMploB2Q9VAPqqcPh67Y3xFx5jRAfQnsSqSQTr8xN4Hd8+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDNo5PZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDNo5PZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2799D1F000FF;
	Wed, 16 Sep 2026 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581512;
	bh=xZFgqAZSadlN2hEBLqqOKQlqQ0FRm9esvChILrdV8vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DDNo5PZ7usNlDlyfBFY4+MKtjCrbQA88DgN3varIN6t+Rl3d8DikVbmSMF7gMqJoY
	 EnwYRc1dPX83+ljyoSpzv8YYj4SmeLdZV6i4EkOOn/hihmjQxTaE9ul0+1v34Yva59
	 C2mnlUQExzn1/53Hju0hJ+O2+s36rVSebiPwwsWnaq8TYP34I8oqzEdnBlXJK6K6qp
	 8Mj2NX8OYPfAvjSf5DPSSRwLfaEb9zMpjjeXljzPE9uawKiPil+MnUlQeiRGCEIl2i
	 sI00YZfn9/ev0BJeF3WG5LiiV3I3RDKGWLTmwz4D3nTQhirKwg0b6erD6MNYVU3/pf
	 GLxOMlFpNhqEA==
From: William Breathitt Gray <wbg@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: William Breathitt Gray <wbg@kernel.org>
Subject: Re: [PATCH 0/2] counter: Update MAINTAINERS for orphaned Counter drivers
Date: Wed, 16 Sep 2026 13:58:20 -0400
Message-ID: <20260916175821.1824084-1-wbg@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830-orphan-counter-drivers-v1-0-3b10ab8b3876@kernel.org>
References: <20260830-orphan-counter-drivers-v1-0-3b10ab8b3876@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=wbg@kernel.org; h=from:subject; bh=Ix5YQbxRiGApJbi55zHSXoDtwcQg5K41CTNAs1PkJAo=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFmrbmyUVd67OZVzZWHeYqWbqY4dV989fSlYKlSQln81t UNy46OajlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAil1gZ/nCfvpvVM6Nn/uGZ 0zIkcxZ2b/W8nrL8g6DnBaVX5/Uul65n+CtYaL7kdsHPFfbuO9Tnt+lbd/QrcbNa7Qv703Jpgtp uXS4A
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Sun, Aug 30, 2026 at 05:41:12PM -0400, William Breathitt Gray wrote:
> The ftm-quaddec and microchip-tcb-capture drivers have been orphaned by
> their maintainers. This patch series updates the MAINTAINERS entries for
> these drivers to reflect their orphaned status.
> 
> Patrick Havelange, the listed maintainer of ftm-quaddec, has indicated a
> desire to step down from the role of maintainer. Kamel Bouhara, the
> listed maintainer of microchip-tcb-capture, has been unresponsive to
> several pings for some time now, so I consider the driver's
> maintainership currently abandoned.
> 
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> ---
> William Breathitt Gray (2):
>       MAINTAINERS: Mark microchip-tcb-capture driver as orphaned
>       MAINTAINERS: Mark ftm-quaddec driver as orphaned
> 
>  MAINTAINERS | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> ---
> base-commit: 353b2e09f44a91e64c6b8117df46b6999c52e465
> change-id: 20260830-orphan-counter-drivers-81f28ceae1b5
> 
> Best regards,
> --
> William Breathitt Gray <wbg@kernel.org>
> 

Merged to counter-next.

William Breathitt Gray
