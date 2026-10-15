Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008D58E2CB
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096570; cv=none; b=kizzBNUcJKsrK/wI1s+AnZrsMZfTKMML0GE0dgMV4zSdG57+Eyk4GJ2df+FfUAoMedvzc1CdPNroQLwjm6JhE8ynNHERMmqkMBfJ0G55luDId2Nuza25ul0hPVGL4XL43/n8/ymg88VZDQNT35B+uHFD5nku3AKm+dnKVPNHZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096570; c=relaxed/simple;
	bh=fJAIJMuzJlXMp+GWBJ+Z6kDPcsHz8ZNmrf0ByY3/yBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4AQ8/qX7MB/DEqRMYMKSQkGS31N3sj5vI5ki+LxhH01KeUBs2x+L36ZN32lgZVEAm/Y6krWyj0Hq9ZTx1eIR1j2C2YS3rQTZLq8FKSkbjUFvT0PsZaYyzm0rpd71+JqeaeJG4oBsFgTO+vG+3nl7FllnByF0oakarkijL2aST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXpOkEa+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXpOkEa+"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91b83459526so52889776d6.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792096565; x=1792701365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fJAIJMuzJlXMp+GWBJ+Z6kDPcsHz8ZNmrf0ByY3/yBI=;
        b=aXpOkEa+7eALWEOGtn/4O5gxOpgTm6Qw8lZCnJmtS1Ni/b7aCczEXDbWstV79+gBu8
         zXv6hN09g6wmu6boIgPgusPScdKu5cZHB53ZSn1vKfF8ZU00Bz4rczA6ngf5bmEQkO/O
         f6iQN6sJTY7L03gY7V+zTN3wJ//k/Ct/Uxnl8KirNR5JiSKzqyAdsVMP4kvhzk46MAYT
         JtMZFlPfHCk/nYQdt7QljpyFz+ovK9oYL4BMTTeXCcgrIYaQj84O1DuqfKyi0uHdTuQX
         BVY7XVCENP+P3faOU7Wm5eaxI+Hj4KbYuaT6mAIDYu9PaCoiLpYY74KVjcIMN+6Nssd0
         DzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792096565; x=1792701365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fJAIJMuzJlXMp+GWBJ+Z6kDPcsHz8ZNmrf0ByY3/yBI=;
        b=QWCh2ViAcIrLIhUv8Rp1bO4lJpvHvj3yv3O6OqeP3KOBhIiGEH7JcrCT51iN3TDFSe
         h3qRa0J6yWCqECfiCrL0vFLhCXAOX+PRTr7hae2p7HVZ61WzHFNL0udh9ACTokVoV7p8
         PvUeEwD/eAI4nEEF800rGbNTBcaJycVGErjxnpOe+To6gngpwJRSnXYoI/oTbaX6X3oh
         qQzaU22H0niW7ALNCnjduYtzujAA6EzDBcVo76uLfjkETwgYe5ArSsqn9NvpcfKrKB9r
         8EqBKnGdUKR6nRbynJCoJgGaHvK66/HcWIoYKTbZcVCodg2qd9HPBu5bfEBaZHJ67zmv
         ytfw==
X-Forwarded-Encrypted: i=1; AKwUvBxSzcXgdUjshdcJL7AeVJ0x4BcrvP5LEAMl+gXKg+xpufiO16prdUfEPgWivbvRfpWNcC/zw1ALaMU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8/8USWq4CgB7a6R/84/NkpPcCw2zzzAQ62z+gmAbQEq/ockuY
	2/zLd+SI060Pg35XfNCTR+v+KlpBalB91+tTJlS7PbFElyVEA5GLnSRP2zpz1Q==
X-Gm-Gg: AYBFou1m9S+Y0Gh8eZSpc8sm/uLewlp9IzDfBHek7p0jv3MzLvY2RHDn0MLKUm5FpJU
	ttRGQUXQwlAxvZ+F0HiwLNsQY379xO1gDdkDafQxmSclKTQrB91/wI7j+MLiSdJV+4VOqR50cXT
	rbH679e8oE5FTGjPagNtt5scRmdgXq8TtLlJ8Yalrs41ldmvzg1qMNJ0hs7Rm1yIxPz++J9xyTz
	lup6VnonuwLHHi6IUY9IzCH7apKzCiwA3VEN8cD/x5kcHAKFtOXJBoElMQnpdWDV1WODPd076lL
	ewiMne24sUe/Wv/njStL/g8D7cAD+y1WcicyxJX6KajDbk9w1x+fL/l2Ufelw+G3WNLHntzBDDd
	oMSwcpFlJgS8gK+8FV6T5MKatSSaUkhx/Cqlb4fF1ftQiXXKJ+KdSjrO1RJG9/MM557iETYuAge
	jBolcIUelYTfNQmEhgyePjGQQ7KzSyaA7FmM1us3pN2fctLv5MwWKuQ+UTAnGz/1JU358A1+DiE
	UptjW6dFtrgNuGCw5oIvaPXhw==
X-Received: by 2002:ad4:5ca3:0:b0:91b:8afd:84e2 with SMTP id 6a1803df08f44-91b8afd8f30mr210166596d6.39.1792096564806;
        Thu, 15 Oct 2026 13:36:04 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcba4b9f0sm4844456d6.10.2026.10.15.13.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:36:04 -0700 (PDT)
From: Dingisoul <dingiso.kernel@gmail.com>
To: joshua.crofts1@gmail.com
Cc: andy@kernel.org,
	dingiso.kernel@gmail.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linusw@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: mpu3050: add missing trigger cleanup on remove
Date: Thu, 15 Oct 2026 16:35:59 -0400
Message-Id: <20261015203559.2125485-1-dingiso.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015221818.09527ff6@systembl0wer>
References: <20261015221818.09527ff6@systembl0wer>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joshua,

v2 looks correct -- mpu3050->trig/mpu3050->irq are now only ever set
together after iio_trigger_register() succeeds, so the unregister/
free_irq guards in the error path and mpu3050_common_remove() can
never fire on a trigger or IRQ that was never actually acquired.

Applied it, rebuilt, and reran my reproducer: the trigger now gets
properly unregistered on unbind, so the attack just gets -EINVAL
instead of a UAF. No KASAN report, no warnings.

Tested-by: Dingisoul <dingiso.kernel@gmail.com>

Best,
Dingisoul
