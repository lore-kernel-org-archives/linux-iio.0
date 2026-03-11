Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8E2E0B58
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258393; cv=none; b=jckf6zsdE5JBg1dPU1Xd5tt7gLtt70Pvs4HC7u9n48z2NZ8zHnULbFJW201v3HCnSoiz2QGri2p5ASBVyrOUgYQYrYXHzNF/4AMUxnHZUgf+jGXZz/QzoF+IKVDYJY7x8J+1WmqKeMA3eTIbBv/j+NCTxvOaCKIB/7QbCPILlts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258393; c=relaxed/simple;
	bh=SuyAIU97sc7OvZ+7TWVVigAUtVzZpnLHp31eu/m3i28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rJdB3Jqu5S4mCffe2SCs0wCg0X41xY6SeewMR5OKQNwihiFqvEIN7FqNl7EsSGxXBB1nPZ8RYlSNdCdfavh9m/zBgeTBj2MLgubMwcSn516wzbYE2rhvRd5l86lqePfiuWm1Rr74eCexfcmcuUdiaYS4GLEYTrlzlcGbYKkzGYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTxWr7V+; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTxWr7V+"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64c9707fc11so222837d50.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258391; x=1773863191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8x/j0D3rNYXXI/9q1LMbwzFTmsh0RPYwN8v6ThOlPA=;
        b=WTxWr7V+7PRjFK1R3lRPiyBfxNwf6u/mOsP6glNLO0LsM7J3l1ADcpWn5WWCi0kpjU
         thKWdfEMizc6IZ/TUie+qyRAr+fyCX5/audCVIelUqv6qR5SGrmYJ+ASBML955DdovXC
         6Ccat14eG0Dn2iy3gzHXYLMyZedruqHEcxQLQISIdOafuqD6mcgkTxNRkVpeL+e7g93V
         xR49jC+jODW6rI1wAaDkeUofwiKeknFGfAx7HM6NSH9J+AmjLjAGcGUeNPD8uZWsFweY
         qHfhz/1CwIwcnipZToPDyZ70w0zZMvNf0XLG8eqKDs52z4qsBaVz1vy/Xj5NEr0H0nZJ
         mCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258391; x=1773863191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8x/j0D3rNYXXI/9q1LMbwzFTmsh0RPYwN8v6ThOlPA=;
        b=RR8wTR8Pq74IEUI/lFAO2HCiwxCM1Sje7GY0nPUJgWYwr353WC/z3QmXudBf5iqCLG
         Ddbe5WLFPkWzbaq8uugIA4cufGGesHFI3E/gaYim2E7/Jx4i5oD3fZawmVCZ7w2JPMm6
         a7cf+YyoCvRKd3D+Gk2BGYiaAU9JKPS7f5iIdmB6faVOvl4cdLzh6yga8bAeCd6DL8c8
         plgXANJt8PqxIxB1bKOmhxjdoeCcvMz7p9VJ2zI9WKzhDwVtiyPEXTX78qAio2z4v2pz
         ksm6p3RlqQ9GLRt7AIXrI0bFzQVanN0p7nj8NeFgVPsRxmRvpJ+1fIP46+n25izAuOX9
         HGhQ==
X-Gm-Message-State: AOJu0YxPGHuP5eqQwXJCFXAH2lSdWKC8DnDns2hNu0URfC1XseDKq4tG
	MeKWXMg8a4Uj1dssI4ACZTkB55+mTW1rEMZVlCW81CdWzh9jyxJktlVBqy4YIA==
X-Gm-Gg: ATEYQzxXhwCExoLOFWC8dDhhACsg0BdYlEHBHFCaK9PuP+gAT2jxSDsCRkBnwY4xjYc
	NF3l108jzMGbtwqZuvWCZ/PRQxL9u1DtVvWjXqHqmOt+/9Xk0qax0iPzKI6wae/AcT3LEZ+Vb/N
	ABR2B4MBx7Y3fpeF2VcKtPGCSnon4rwTpn/VW+nApl/Lr5EJjUlKaR227rQFmN4pnCXH4aKdz7j
	+kosUU8ZUdmWwVOnXN25KS8eyp3xp8werLw1uBIAKpReV9/s2gJk9vtNm/MbrAJhFTPdWuaJB3D
	dcZHX7RDtGI0m/DZr2CvyTnTkyc/tLHNjyVavO2Wmxxd9/Mpq1Pq1NuJ+buhNrriPJCLTjrM5i2
	Qc0zrbFlcoEK4t+VSX3SpFn9jnF7K0IMctp0Se5FGY+Btl+EaH/eO9rUABiVDASeen2LKT6Iabx
	U1ir7up+nGZdUq6hcOgUIM/kLIRbj6lYpFQ8F1DxzSrkFocZxGJYlcJT7cI02eWgwopEKzrYI9h
	zhtFz8aSrCnB9g9QFa7PLuPJ+xTTGNTm24r0esAxzTavzNieRM6lzpL/9owbhgXlsEk7YIe/EnS
	iHDxLhmM1w==
X-Received: by 2002:a05:690c:386:b0:798:6e69:2470 with SMTP id 00721157ae682-79917eacbaemr35208777b3.3.1773258391205;
        Wed, 11 Mar 2026 12:46:31 -0700 (PDT)
Received: from localhost.localdomain ([2600:1005:b11d:678c:38a4:272d:91cc:6439])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f268e5sm18217927b3.46.2026.03.11.12.46.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Mar 2026 12:46:30 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [RFC] GSoC 2026: Transitioning IIO to guard() and scoped_guard()
Date: Wed, 11 Mar 2026 14:46:24 -0500
Message-Id: <20260311194624.1521-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan, Andy,

I'm proposing converting the entire IIO tree to use guard() and
scoped_guard() instead of manual locking. This would greatly reduce
boilerplate, the possibility of lock leaks and modernize the entire IIO 
tree to current kernel API standards.

$ grep -rn "mutex_lock" drivers/iio | wc -l
874

This would have to be a "Large" project according to GsoC due to the scale
of the IIO tree. If this is wanted, I would like to know how these changes
should be submitted to make this easier to review. I was thinking per
directory per vendor. 

Looking forward to hear your feedback.

Thanks,

ET
