Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0A22FF22
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468340; cv=none; b=f9b3BKIHf/J0nRms3x6xnkyscSlV+7LBDCBfk9pELQ0PQi8lhOTXwWlx3K9dLvE+5u5D4DiQNrYYq6xeY3yg0eZtDptqufX4ErHb/w24H6DAp6AxbQFIi1vptOd/YzrYWxRizWBa7nfmLtKLTxw08lWfemXMRFtkKeKgibhHTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468340; c=relaxed/simple;
	bh=bKpim+9sp3trzvCBDLJ81+RdtyUmA8yRp5E2hrCBGGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl6ihjpMxiq7QMJWK9RUDCr0OxQXtLrkym6i9w1MYdzGKCm/ahS70sx1lItHY4SAAJbfbrYgWPm8Qw8uZCH1sUTK2UoEknpHN8zYZpQIpk83q/7i58zizZWA9k41iGpGnWfyk2hVUrep8ocIUzYfXov0kjvJhJ431iuO5EYA1R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFEb6Dar; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFEb6Dar"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bebbc325000so449946466b.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 23:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780468337; x=1781073137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Dqle1IgOBxWtaEbNXYbQA6N3q7speS01xaOOqTbaug=;
        b=ZFEb6Dar4w5VHE5lJKPaOrkJiJXq1rpAVDHXeceRZw6JQloPtgvF9+O3B05JvsWa69
         TPYBfhzyWr43lfjqNQO0nyoD18pB3U6mcT2GhVvpJN70NBTMwSLRiTMh5c6+pafEPopJ
         JZUGUQtOO10ioy19yqFSgp8HpnDvVL/+rxihEh83vu6KuWnuJZe/k5o9/rcVYbwDBgTZ
         kvPFZe0bjcNsGQ/MEPyA9PHuhrtjF7ZpFFLcUjyv62Q/p6Pqe7QKyPQifmeJ5hSDNns/
         q/bgMUgieO1P8Z1nr70fpp4qeBTxVKSDMq/WWlmWEjtWAF2JWpAIgCk+7CEF/YUeoYtl
         niew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780468337; x=1781073137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Dqle1IgOBxWtaEbNXYbQA6N3q7speS01xaOOqTbaug=;
        b=okYeu3WtO0q/93oP/2PNbR37FPKP7C2EcGkUnTE1E2XsEwXEi7F2VRkXc++cA1eN3W
         CITWfGfR+oYZjFy6EyR5/eH1VvnsUR+H71GeRfgkTL8AkrDEhrBgcQTLbLqeuT9S9JwL
         z6NM4s44Oa7xnbyV0ELxMS71etXHNQy73hP4l5upkDjngHaLwBylT2Yosd3S9yFA5r1o
         GQ4vz/O/GZdaNgkODVxuySH5+xn2QZXEwJ2LwNq0KFTQbBzMHzXvwVil1PSgpKugM6Tu
         7MBychuHumqyVH91I0rfKlX/o/swcypGU0DTYaG6MMCw0OdQ0lv8eHv3Zx8y+4LpcyBl
         GLYw==
X-Forwarded-Encrypted: i=1; AFNElJ/7ERC7Fofu9uM6CBZ8DK/5jQXphMzf0KsPtbh4KN1J+t48T4vG6dfDzBzc7LGw/aMiIdRnvJ//40o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEon4kItj8RwpyJIn1uoxMBTqPbdWssxGMLgYYrGDH6HEPv4U7
	qYAmTOQsSHimlv8a3/C8CRtSU0CAZt8djzEMaILZSNDkYCtW7U02S/e8
X-Gm-Gg: Acq92OGvtRynIJB/SMKKs/XWS7d162mrkco4ZJNXHGbmYRlKGUmJ+HR8qYpzrOFNfLM
	bQrlYa2HAGRcwWPBR03C2KJ9LozpEZUYmDiZ++wM3R1fkLrnWlCdRKMB1lbLLXqA37X3jK338N/
	U96OTdbx6OFGwRjIJsafOJrarlZQ+H2WAJRd7yvyEgKHmVBzbZFgNg8TZd8TiJAe7dOvfiD5WoI
	FJltU+TezVnfJZbUDAxHXBK4VJhWiWdBiSwjEJDO79Fn+hAKhpo5ga/ieYFVYAkIR3xwXpylH/l
	Qb/780V/3bQuOVZfi4P3s5dPtHYE1qQ6bhUGT3SNH3qpPCPTOyox9d7mWebXU3N5qJ+EWTr7Ooy
	bBbKOg+Az3TfHYUrLYT0ISE/TfD8rZE1HKhL8lEDCMBn49EmQQNXtpM9FDgTAOPAZ444yt0EV0L
	HYz7Q+cpXCvxF/o/7gJxiAoIqt/JXIsQ==
X-Received: by 2002:a17:907:2dac:b0:bec:64c3:9ac0 with SMTP id a640c23a62f3a-bf0b10d94b7mr74001366b.14.1780468337235;
        Tue, 02 Jun 2026 23:32:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e051cfsm91327266b.38.2026.06.02.23.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:32:16 -0700 (PDT)
Date: Wed, 3 Jun 2026 09:32:13 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jad Keskes <inasj268@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2] staging: iio: addac: fix CamelCase naming in adt7316
Message-ID: <ah_Kbff-c38NWV66@stanley.mountain>
References: <20260602190308.158051-1-inasj268@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602190308.158051-1-inasj268@gmail.com>

On Tue, Jun 02, 2026 at 08:03:08PM +0100, Jad Keskes wrote:
> checkpatch flagged a few CamelCase names in this driver.
> AIN and DAC prefixes are lowercased as standard kernel style.

The AIN things aren't an issue and checkpatch doesn't complain
about them.

> Vref is kept capitalized since V stands for Voltage and is a
> proper technical abbreviation.
> 
> DA_AB and DA_CD are renamed to dac_ab and dac_cd to match the
> register constants ADT7316_VREF_BYPASS_DAC_AB and
> ADT7316_VREF_BYPASS_DAC_CD that they reference.

This sort of change would need to be in its own commit.  (We're
dropping the rest of the commit anyway).  The difference
between DA and DAC is not totally clear to me...  The
adt7316_show_DAC_2Vref_ch_mask() function only seems to deal
with DA but the adt7316_store_DAC_2Vref_ch_mask() does stuff
with both.  So I'm not sure I understand the naming.  (I have
not investigated and this is my first time to look at this
code).

regards,
dan carpenter

