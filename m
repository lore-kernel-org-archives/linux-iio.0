Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5EB3C3F66
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734268; cv=none; b=AwE8guIZJtcmfPW1miHev0GrG0T7t5CA7nqtM/BxVbiGPTIrcDlX7FCl6T+5YXuAcrYZ6jG8Mrj9mknJcnFwLdK3hfxUbZ8OCbE9chs0KX7JizY+9juxsX8JvvPPBsDTR1u7vf5PwHI0y0xwSVMi+ClbEAccBu2aVnDBJ3FOh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734268; c=relaxed/simple;
	bh=0EUv+GanEqAn1JfFtrxNqUFwolRcvTRXOT2sLEu+pVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cS8ulQaoUrH+VDe/YgFcK/C+QveEsEVGWToLlbpnSE+6O2E1vIfi/narSwjF6AKHl85MkUMXNxntKdMbeXmZK4VsHBXVfEAAPKURKKwQUmnhr6WmdmXG6FSOqLHVvxLTjrdc8rjp3rLma3xCvVqRjHHy/pvGQfrRTHWqF/hKrEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTu5ojSy; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTu5ojSy"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a354118856so5398421fa.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 05:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789734264; x=1790339064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jXA5dsmKNEnAug+zqks6Fez66gO7qKGJLh9NGBSeS+Q=;
        b=oTu5ojSy+vFsMb2aYIMouVUYShkXf+/soY/Og3hlw2QjBAhuFiLKLkHVVUeZKxf0OR
         RFICmH21xAWOc2SmGfT4tnHHL3Y5wSEKtMfrM8W+BjERj9WF7mTtT1AvpFhPT8QjXhny
         EPtZjqchjicUMrdgvbpsM1vPZZUisXUcTI8QZIm8oax18NYxqn81PS7y6cZKYA/0JmKF
         +AYVemn+NtE9eydvuykE4N2u3Rf6C7j0KCjCtrQIpGS0AsJdbjeHt02otnCfcjM35K7M
         Q4XrhdQh6J6QaAqftVuNfXCWl3sGGRunF+Er4/bcM3dasbQoshSyKLk1ktUiaCbDJxFh
         BD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789734264; x=1790339064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jXA5dsmKNEnAug+zqks6Fez66gO7qKGJLh9NGBSeS+Q=;
        b=EqyHf8+NHeODTG0fojybRaNAlI9d2qqzmaqaPr8nzPdVAG04/sGrcEnrIsIUOh1Shu
         IFe/KgLPB+VHphZIzeHBHGD7C7OTP/TsAGcgvQ9zeQiaGIuNkeeHItfwKsTBtXsG+DaZ
         eIBO+/qjM6Nq9ex4VAUs9r3HWvbM6BYOwQoAkjU1SPdx8oP45/3GgqjnShkZZHss/tWr
         FPvq0cvE0xx3goXGAO8pMmMw08+5SQZ/B21aJeOqfO+PN/5fBGS1GR40cV/JSWm3UW34
         HuVObGODulRjWq2eq1/DdjdZBNCkOISOZ3FsU0hl33P2jxqWlWb5oL/AVUIXEXJLphkn
         QbBQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9qMu311i5NF7S6142KeqsM8emZhAPXA2QMPWv0MVcaI2XWz/dNexDAJ6c0E84a105Tz9f8uU+Nh8=@vger.kernel.org
X-Gm-Message-State: AFuF++lJk7bgLJO5yCqWyF5AaIpfm/IXpUfxnk9FCK6vcmL4ajvfh5ZW
	2LGUac1y0B5eGrThJCRPf4+lhHaz96isUMlQd86KjVUNU3bTlrVKqQp3
X-Gm-Gg: AYBFou1961m+RSH11Ed0RPRDZLVfXoTuMUp/vYdCia0NEhVQ5VeBrCT+cmKm8cwKv0f
	z2B8MSYsRt/odgnf2pstg/3quAcP0LfWyWDvpR0kFUCLd1MA4QDKUAwGbxsw0Hlc/PdTUrCAEQl
	c8VsSxtjvQ+fkyrqDB4EVPdNIUQEpvt/e0IVwviXP20TDRX/O8dMeUFucOxuR+xwOEtsIEph18y
	utotySUmXQKJomF6r5bmgg1WnZxJzIFWT7dThQEZpLp8ISChkALdcvTcH5r0neGcMW1GMgBC73J
	f/YyFUNTn0XhtSutTmqBNkwA/Nxh9gsg9vR1flKjSp0u7e5QxnbebpiAVXh+c9aa7SWvK9NSeCD
	uA5IMkp6KM69TPFcyTg1Qzuk6B9IF53LUk1x+/U8n2n8ijnHdlwDfR48xYGu3ZO9gYBU07Q0Vc2
	vXpDwd1D392sjU46Yf11iW/EUj52RP641INJWe8+EIsDd5jUGr3vsl7KR5AuaPyhnkG/4D1iVOC
	4qUwAOZKXUZxIK4lK/z0dhsemtg8c4zZyDQ1XG/IvUDEQYU5IzwAjkuW5K9gIqUPKTREQ==
X-Received: by 2002:a05:651c:2113:b0:3a5:db7a:23b0 with SMTP id 38308e7fff4ca-3a5fbfd830amr4870991fa.22.1789734264223;
        Fri, 18 Sep 2026 05:24:24 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5fd7b7248sm4526681fa.10.2026.09.18.05.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:24:23 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: jic23@kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v6 5/6] iio: pressure: dps310: add hardware FIFO support
Date: Fri, 18 Sep 2026 15:24:22 +0300
Message-ID: <20260918122422.375244-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178813888151.2788519.16547013180884814648.b4-review@b4>
References: <20260824201203.396651-1-zoone.rupert@gmail.com> <20260824201203.396651-6-zoone.rupert@gmail.com> <178813888151.2788519.16547013180884814648.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 02:14:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> As before I'd have the structure locally here. I really want to be
> able to see what it looks like.  Don't worry about the small amount
> of duplication this will entail.

The FIFO path refuses the timestamp channel now, so the two channels are
all that is left. It is a plain s32 channels[2] there rather than a struct
with a dead timestamp member. The trigger handler keeps the struct.

Rupesh
