Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916727B35F
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776517412; cv=none; b=ra7QsWXMcRSLiPZ9eLbS/yAAICFwruegtZOOunp5PC5SdJAzOhiy0j/3omLo9GjIifFnPt6qPZ9o9w60ocnxM3215FhpyAJbV4rkraQ8uo1GVxLcqE7/zUCBr5N3ks5U9c3wJGdQUOh6etvFTeB75724fviLAaZW3SqjEMx4wlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776517412; c=relaxed/simple;
	bh=al3zLxrlBOqvESnc1RC+9i6YIKY8eeEhj5KZWUed+sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAXOXuMT+lz524/Q7NiFYT8fZFPJahZAo08x7HZdC/1S96QmtSH/kmhsMzdY+TA75iRCKevXmNNSBJWCeY5/ak8EIo4MDlAidOr2mSo5f9ciAwcHJ3RrM0a2Phi+a5OQNkNToFD7+LZwWk9THTz2xPv+aQo9+CJPTAoaeioL6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=mmYw7Qz1; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="mmYw7Qz1"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c63e942f3so1054119c88.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776517408; x=1777122208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivlPMpQLiM69pg221Jil2E0iEMjhHzsGwCq1AD+Z3To=;
        b=mmYw7Qz1hhjdLsSUXRaogUFmyvw5cnaZh7sgiSVYXwGtSAa16U+g/a0uF3aRHIKIy9
         gkTjhVIbvVgmKhfLhlVDdwZsMnCg97SAn1t3+1miJaiuRyMRmePcJG1KGtCHXHCenyte
         TdI5obNXnskQ1qeAhcg0xeWCAt2xPxoRNmHKsQ5tqCT6TYcSmLUtdNVNFhiUhfShftpU
         ScpFIOpeZ2NeBl0LYfnifNPiwc0DqWPXfGgYpAxhwn2s0iLEldHQ3DvPS7biAPgyEdmF
         knLeQzDdMqC2SfvCWEI3SKFsIvo0Gpw2YS76LD3vFbssLunftv+f6pCgOAwX+Ztk2L9n
         Hx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776517408; x=1777122208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ivlPMpQLiM69pg221Jil2E0iEMjhHzsGwCq1AD+Z3To=;
        b=B5W7+B1aK7UAswRDJ3PGQTkNLSYn3qCx8qbnpEoB4XfaFNarP6Bpkonsdh19tPkSqx
         MDRvVAhgILeoh108itkjPF0dx9sdNTHdlrV2sD0zl2f7vsSObdqisXgZn98sBmfL9fa9
         4rkH86K+DwrhIENRdAYsM9+tWDa3H0WdG1cXedrnHgl5u6cEtQPt1wFurJnWmypAyKb+
         W3znxvLbOtLvCVCjK4X5ByF5HKqe36Pp88Gqf5vFSnN4T3T0/1LMogl03rPVfevFJvsM
         QYF3EAhxTJenL3XRss91KGK6WYzdo86O7x8MyRkiOquzLxZgUUatp1STky58ihzbSDmz
         VdtQ==
X-Gm-Message-State: AOJu0Yz7vI7MWSjcpyaAHkt2UmIQ8cvRfqvkTlc9OBGQpdkAuvz/NHlB
	BMYyqAgveY8bNJtBoIr0ESaJdaqdZZaxk9scv/N9QEwX9mlghAYFRTlgqfj0eoReq+8=
X-Gm-Gg: AeBDiet7RrA2F+hq80+otVow7qWKIhtLk7XHhqG6UYw+2QfBZ37COKvCAr7BmShUR7S
	GDzco6XNie0KoQxc9NfNHCEdTggUTT31iyQDdfxowT5+E4VLzTAIX46bN6h8IfXAyYx77ai2pcm
	BgE1/V0Mvmy1Uu/qLP8I71eq8c5OODyb76aFPPBd6pn0Mz/nna9mWFEC+zRUVIfpMa1oH8UsNsC
	62AT0ZRitbDesnjE6NGLGmg6Z7LVOO35YzDFyXd686R+sb2BYW2J4h9nBDmwABDGx3wKijKvhX5
	gAbXXv0GdJJ3/NJy+UG2fCNDhZgmBbNeNqZrU9mjsloWAeOhkN3pSsWh9PV7GNk9U6C6xLUMq5t
	wyalUN8WoIWveJ+vTboK3ZL9zs8j2rpaZeunQhqhKBKyG+R8JsgLPEa5DPZcKI3YtQpKDQHcTIw
	o3+0plKgx1RG26CL51W11Gf/g1K/kpT5mzjyyMvP7HXkHfK56K
X-Received: by 2002:a05:7301:d17:b0:2d4:aa5a:391c with SMTP id 5a478bee46e88-2e47845419fmr3447206eec.12.1776517408308;
        Sat, 18 Apr 2026 06:03:28 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:d8ed:6b55:82c7:991c:cbac])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2e53dcb487bsm6501051eec.31.2026.04.18.06.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 06:03:27 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com
Cc: linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v3 0/2] iio: dac: m62332: Use guard(mutex) for locking
Date: Sat, 18 Apr 2026 10:03:20 -0300
Message-ID: <20260418130322.106769-1-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
References: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors the m62332 driver to use guard(mutex) for
simpler locking, preceded by a header cleanup as suggested by
Andy Shevchenko.

Patch 1 applies IWYU to the header block, removes unused slab.h,
and sorts the includes alphabetically.

Patch 2 replaces mutex_lock()/mutex_unlock() pairs with guard(mutex)
and simplifies i2c_master_send() error handling. This patch also
adds <linux/cleanup.h> which is required by the guard() macro.

Changes since v2:
- Split into a two-patch series per Andy's suggestion
- Added missing <linux/cleanup.h> include
- Cleaned up header block (IWYU, alphabetical order)

Changes since v1:
- Split combined condition in i2c_master_send() error handling
  into two separate early returns

Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>

Erick Henrique (2):
  iio: dac: m62332: Clean up header includes
  iio: dac: m62332: Use guard(mutex) for locking

 drivers/iio/dac/m62332.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

-- 
2.51.0

