Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071C324B33;
	Sun, 30 Aug 2026 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788126954; cv=none; b=uJlb+DnN1QfV00DtlUTtfX+XtwbUHxsgAUcI0lNbSSImnOzTNVLPwwootr9fVs8hpshy/YAYSFa31+9jEU3wX8yfJEByrgx5ffrbWVYzthxrrkhdYLSinVB+8V5Eb3w1wJr5i3X3aTuK+p13rIbo2KAAoTBcsAbnySVBFeufQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788126954; c=relaxed/simple;
	bh=yapKRDGzt3z/DyYa54mrH5TNTT3gsn47aDoLdgmB2EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VODSYjxHOKBcV/9e/oAjiUivq/QNZpLvc/65q70iodW567JpqV7SrfABNZ07UKmbXhK2qPsvDwSBG7XSbV2gUnXLz6yy4HzOAL6X8F30d4AiNpmfyDVUPJtZpPoeP/wtidPZh7XN1kGW9QvktV0M1jWUAFzM1uiJhuYuG0erdQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhgxnXje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhgxnXje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3D41F000E9;
	Sun, 30 Aug 2026 21:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788126952;
	bh=BGhGFlBUGOYhmG7/RCTZx4wzUQC/JjStZaaRuBTWVfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OhgxnXjeiU/YDlmQ3bnjtwtvlYh+FlBVmXvKFDA/EsceLHNOVAKod9jyi2wp4zNTQ
	 Zu20cS9eqr/kyiUb9F6qelX0kOmTtM9XPiz6CyirI+cY4nGAJykCJNrb/tw+36oxIt
	 QiS3rLJ1buumXts4AaVKc4Lvnb5AmBW7Re7ZzbK+UMQpmfe0xlx1nZMO5RWV7Ihxk0
	 DlNm/tH0Y+Ot/IWG0G95YfTxQnh3Ac/8g1Uz5fS25LE6bdSD38ZGjbdihSQ6ypG1Xz
	 QAX3slQ1yvmpQ+h+EpJjQKFkrIBUElnRwME/BUxGikhV6vKc1/sRjnPtRDCbBhh9On
	 U5qqluBm3TG+w==
From: William Breathitt Gray <wbg@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org,
	Patrick Havelange <patrick.havelange@essensium.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] counter: ftm-quaddec: use devm_platform_ioremap_resource
Date: Sun, 30 Aug 2026 17:55:42 -0400
Message-ID: <20260830215543.1051817-1-wbg@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714234350.892367-1-rosenp@gmail.com>
References: <20260714234350.892367-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=wbg@kernel.org; h=from:subject; bh=yapKRDGzt3z/DyYa54mrH5TNTT3gsn47aDoLdgmB2EI=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFlTli1mjq32t1db1adct6rjJvu1yhmzjX7ctL6ntOLOh dCtQhusOkpZGMS4GGTFFFl6zc/efXBJVePHi/nbYOawMoEMYeDiFICJ1D1k+Gdw4MvnLT7lzXl2 Qq4Xj2SYs56Ke5Qm+v560s5TicELxUMZGU5XT3jm5d//1jDo6uvPD9ubT3w9xpH124mNS0k8IO2 2OA8A
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Tue, Jul 14, 2026 at 04:43:50PM -0700, Rosen Penev wrote:
> Replace the open-coded platform_get_resource() plus devm_ioremap()
> sequence with devm_platform_ioremap_resource(), which fetches the
> resource, requests the region and maps it in one call. Switch the error
> check to IS_ERR()/PTR_ERR() and drop the now-unused struct resource
> pointer.
> 
> The DT nodes (counter@29d0000 / counter@29e0000 in ls1021a.dtsi) each
> have a single 0x10000 reg region, so the region reservation added by
> devm_ioremap_resource() is exclusive and does not introduce overlap
> failures.
> 
> Built for ARM (drivers/counter/ftm-quaddec.o) with LLVM=1.
> 
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Hi Rosen,

Patrick Havelange is stepping down from maintenance of this driver, so
ftm-quaddec is currently considered to be in an Orphan status.[^1] If a
new maintainer comes along in the future to maintain this driver, they
will be able to assist the review of this patch.

Sincerely,

William Breathitt Gray

[^1]: https://lore.kernel.org/all/20260830-orphan-counter-drivers-v1-2-3b10ab8b3876@kernel.org/
