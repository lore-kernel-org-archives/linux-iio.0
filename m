Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F63B5E10
	for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2026 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785303665; cv=none; b=MJ1KbsUd5Xrc4bPg1+qMkLRZ5XicfKsZ2Jku94W1+fCtxqIvYcb+wi2XLCiyHH3XuGonxke4aYnyDsDRn8yosEdugfPFdKvJ1tDflnylHga4q01wB1bxMQD5nhbu5brvSLSmbWlV7jMUIAH9M+A/3487suPK2xU3NSHEoiOhHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785303665; c=relaxed/simple;
	bh=lfTYsE/6ZAFQj1QetMnj/IgohbPhMLjdhTn20RmFQNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQIaNTbKN6eZLQ+UwyZftQPIlobVL0h5TVwr4W/Z5N7LKN3HZk6c6PUZX0YnbwKw1aVkwa4j9cDFKfdK3Ru2sYK08dB6y7fHlDG8EKRN+IcRZrIdEoKNck5kF6Wp+OgSy2bDI6yc/FWbBlVHTuhhrxq412oPeFb9gaAAdJ1y6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su9md0p5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su9md0p5"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e04df8c46so638494b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 22:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785303664; x=1785908464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lfTYsE/6ZAFQj1QetMnj/IgohbPhMLjdhTn20RmFQNE=;
        b=Su9md0p5mcPMYMgqljAllcKMa/e6vk5gxAY18X8Vjcd9r/ulSNw6jmZVkAxcOPM2AS
         4hF6bBgqk64yGOF/iBdmeHkVgd7IBfc6hnNgfzxyTtvDkFrSw29J1goTVGAJtvbqdvPS
         cxNYEf17RvajNYLbWVWdm0QqnWmSTIS0no9keY0Ou1NKZzoLolcZuo/4srOizMie1TJe
         LV0kI0wFrJc5aZdVTHJxi8a6VBX1a620MWukNwlCy07dKHaxddfzhj22mic4gUTQ+qxh
         Vod2SgfV0w2RSajAvjRWn3Ph94OKX21XO5K2wSiIsqJxrLERi0EiRYSewDcl/LOASw4O
         ykAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785303664; x=1785908464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lfTYsE/6ZAFQj1QetMnj/IgohbPhMLjdhTn20RmFQNE=;
        b=jt6aamE+FANh4yYjQS8Wsb/Nan8UqlVRu5BSeHseRualwj2bNgvGrDnUdHOFptb9rA
         iTe3hanQ2nJmuj0mA8L1jnYoMOWA6/JsgDeODh5gnBTdb8w6uOUhT59YhXVa68daQP6J
         fflXxOf4awCMVpFlbAKemYkqMbi/jn9ap19y7iy59yNH/1D4u+SO3aVsC5/gZW0FsHnS
         eA+06pA7pz8/chepDJSfIQDDpfm7KTuFOUoeUvolZ2/I4NmUgwnkOqWSmTWU8X1txNlh
         sbIUR7Nq+VIx/OH5TN9FQudpCFBbT+mlayxuVwc/uOVw+q371oETHT9PQyrN6kvU0Ve4
         eVaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVn/tYyN+mv/AqdkbfIYbCqOYwMagB7CT1Gvo117z3CoScHp3e7zWoM8ewPRJtoaWsfqrQ+vxWHOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGz8iBZwh/mWShNhq+WllyXbtywHuOLAANEXXU6qrPDEyu33LB
	2Z2hiI1sGy/6O1t9UsH6TVj4uPh7I1sfBeNItCWP9pmzaC1p+iOzIYfE
X-Gm-Gg: AR+sD13BxL3y9+m+N7gHphneBzrMj6H5S/OQUrNCUzVl2ZibY5rKPd5QlMn4KfLicuX
	a4q1sebrjJ2gSuzz0coRZMhhC23LjYWjWV3o4P3G6TIpPHljoqotPheRi+RTZQAKsPDG8DpfTdq
	RZNHiBDmWQaCwSyPWiKp/oxOPEGHDvLrsiMc63LO41j+HcszHO28iVdiKuWpPXJbZmedHVGa5tw
	l/aEgw2s93lPWoC8uNxQwQeofFoZ4Kpo5/tIs5ScD7qRBrhh8ryJYiXHJGP2JQ6fIiiOK1wkm/H
	K1vxMvuv5C7pgDl3pzw0dGd/T2bHEmZk6mqcz08/OFc8dVoeICRiTlpZ8IjxPQFYyS3L6HYOt2F
	TrV/4yP/7hY4uM4n6jADB3xunjM7+WTiZOppYrz/xYntWafInAyW+EXpgwPsiukpW3AWIWZe0wi
	2AifV4pBKYeUAAILKBIUXVs+Qac9fn0Wt8Mc0QaLWgechZeYiML6906TPc/jR7
X-Received: by 2002:a05:6a00:94ee:b0:845:e08c:a4eb with SMTP id d2e1a72fcca58-84e9336c861mr5698218b3a.58.1785303663650;
        Tue, 28 Jul 2026 22:41:03 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02f8473sm774744b3a.31.2026.07.28.22.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 22:41:03 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix DT channel validation
Date: Wed, 29 Jul 2026 05:41:02 +0000
Message-ID: <20260729054102.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714042910.7-1-bbnpreetsingh@gmail.com>
References: <20260714042910.7-1-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi William,

A gentle ping on this one - it has been a couple of weeks without any
comments, and I could not find a competing fix on the list or in
linux-next.

No urgency from my side; I mainly want to check the patch has not simply
been missed. Happy to respin if you would prefer a different shape, or to
drop it if you would rather leave the validation as it is.

For convenience:
https://lore.kernel.org/all/20260714042910.7-1-bbnpreetsingh@gmail.com/

Thanks,
Baban
