Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C191474CC
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338751; cv=none; b=fYfnbq8ksRbtPE8pE4XCa5PT4XEPlhIamjSvCFC2QzuuvdLepErssID2+Dbr6xXoV/c2RIzUFay9G6/FqA6C+eKWX4aENhZgldqYAPtqQ30XSHATJ3Jz1oA7GQdigBBVIgRp9m46Oh81P/hHSikgWWhOKrAcd8NnH2PTveskRR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338751; c=relaxed/simple;
	bh=3IMU8PCargOhuk8zu1IlftykH4zHBta2sZOyBuZG67M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVXA/nQ9E72M+Rn97Td5A/p+m4UqEWRwUsj5GHUmhXJEq1qvQoDLEDWnyAGlv5rrt51lkfLD2HZnRfsARPGKNH56vIg1mcEQHgZRVNFwjpxnDzqLwf/AbToAGOkl8L0Z4Z6XIed1QY7PP9JPOb7qhb9cvQiDkka1QwL31IE4iBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naAPwUX6; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naAPwUX6"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-124a95e592fso232380c88.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 06:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771338750; x=1771943550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZC3/iEZCFsRXh87WSvaZVgKlnDteATCc9u6tQj0BiI=;
        b=naAPwUX6Chlmt8huIdEKEmW5wX94SruQIbEICJe4H1E2ugvyjCfE2bSh7wqV7rWhhn
         JAmKfR3+kV37WxEN6Yx+zrHL6EeB5ZPZ/4LbX/ODt9iaselfb1tWR7cwZH2vqh111kgV
         WjmPvpIzOJyPJacSjOncmG34DV9R0eeEa1BByxh9xH6vaW0GhAElxfxQNjPahVs1lEWw
         iExawRTiMIaj2VmU99UMxmQvdQljvP833VZ8Gr5tUWTX7qlhl46FqOUIbXHBJIWrVqfS
         nPPGBOaPXs6+Fwua/W+ENw4J1G+YggsP4HT+9p5/tl99eQP8iIxZhG9h5OQ0eT/AyokS
         bR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338750; x=1771943550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZC3/iEZCFsRXh87WSvaZVgKlnDteATCc9u6tQj0BiI=;
        b=fyQHM76NYUDOJ+Qhfj8atZJbfF2vfaJrenGcbogd0hz0TkLwwiYVv/Xrin+klKBdBj
         8FBRe+JB+obHqNC1ucKOfpVp2FO22rF+4RekMmbI9OCjcXFRP0d40Z8Tu2ztc+iINUNH
         SPKIA8ea6krNX5VDMEMpA+MqisM6cS3tsazaQ65ImcVYk/c++XG1FJXiquznt/imavWQ
         HwAcdlDpSpr6JDWYgLWJIFhNKSde2Hd/ZHYGmcXz7PHjYKvfZjnOBracz6jbhVLyGsgq
         efZN3Hd4P1QKSm0LHjwZZrN3Cip976Q5SDcd6HXOG20AV+8+i2lqez/1wxq/Qii13k8H
         r3/Q==
X-Gm-Message-State: AOJu0YzEMdXgfEW8t5kBtWO7Yvmd8FX73+NL/cOar66dHWbhLANm2So5
	Od+fmqGB7hQJ00izVIRLKSCI1cpzjfpsx9s4hC8417bcoo8oFF4PSjbzxtjf7g==
X-Gm-Gg: AZuq6aKT9B2CcB7vWt/XbgKFLfG3+InyyA/4KYh00OqGA3P2Ua6Uq+Oi8cLgHyj3bsh
	vIS57hoLXdOK/Mrq5lJgTI1gk0m0yOvqRF2/GDKiMbm/+1LM+izErZXljEvbFR3hZpNrbXv5p//
	o45dYQzH5AjvPBL+DfRC8TbexfoaaS1+UHyBezbKbwr8+enJXnvOZLFVBR6ODu93x26cN2PWLbm
	AkfeyseFWhRj2QOk69SXz02CB3g3GmhyT4rhA4kWiDkxP4gcXTPzyHIc1FNyWXRWONHDtLU9k6I
	emBNRueWMrpEr8fG6Jq2q4gCquPigCuaUoBd5iVXmU+XZASYIR3IIO+8pTD4zFAsXHRRnF7Qzem
	1DBRbzHzqE3dAVLxL0RjbYg2LRH8nP7Ot7QxGQEF93r5m+qYSXHl/j6meaK5A84YJTiXGMelwVF
	5YWhIBTrnGwZck/TXhKywByZJYZ93ybg==
X-Received: by 2002:a05:7022:6b89:b0:123:3bc6:1ffe with SMTP id a92af1059eb24-1273adcfaaamr4693642c88.15.1771338749619;
        Tue, 17 Feb 2026 06:32:29 -0800 (PST)
Received: from osabio.. ([2804:14d:80a0:804a:d4a3:32a3:b3e9:7fde])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb582bebsm13656469eec.15.2026.02.17.06.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 06:32:29 -0800 (PST)
From: Gabriel Almeida <gabrielsousa230@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	gabrielsousa230@gmail.com
Subject: [PATCH v3 0/2] iio: light: zopt2201: Convert mutex usage to lock guards
Date: Tue, 17 Feb 2026 11:31:55 -0300
Message-ID: <20260217143157.132799-1-gabrielsousa230@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces mutex_lock()/mutex_unlock()
pairs with the guard() and scoped_guard() helpers in the
zopt2201 driver.

The first patch reorders the header includes to follow kernel
style conventions. The second patch converts the remaining
mutex usage to lock guards and simplifies the control flow
accordingly.

Changes in v3:
- Split header reordering into a separate patch
- Simplified control flow in zopt2201_write_scale_by_idx()

Changes in v2:
- Reordered headers
- Added required <linux/cleanup.h> include
- Used lock guards in zopt2201_read()
- Used scoped_guard() in zopt2201_write_resolution()

Changes in v1:
- Initial version

Gabriel Almeida (2):
  iio: light: zopt2201: Reorder header includes
  iio: light: zopt2201: use lock guards

 drivers/iio/light/zopt2201.c | 44 ++++++++++++++----------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

-- 
2.43.0

