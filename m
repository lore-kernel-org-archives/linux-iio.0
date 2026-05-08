Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929643AC0F9
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281927; cv=none; b=Ji8b6cw0OPc/yy0nXT5VRAf4YavOsSQ3fjGnPy6YW0Z85GQY+ywCQT7651sRbRjxO2bYA9pdaO+I5RrGwF2dh4pRyvJBMfCdtF9JIiRC6Ruqdm0mIN9YV+ER32+KivyTfUQA8d/zBkVn4WhTK8wRm6K1JRwM/FDu7hFuXb+bhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281927; c=relaxed/simple;
	bh=Rqcuv+zsPQMoE6/4nu2MYqPrBaf48QbiYiBe+vMu0/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gepiCyqvKvjAuBujBdZ+mvgVYCST5NgY3t6Ac2Y62rM6VxfPeBBmdjlQDiul8wcvyTP3NBpigqg0Y6nYMtX1wnq+CbMk4AIsLhx0kuY+lQgnMCaE7o2oK8dGXlGsCBEF1mffFpkmG9IQrsB6/UUy87Lvubu5ptfjX6Yc7+k+LpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGtYiXjo; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGtYiXjo"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-130b2295ed0so7375534c88.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 16:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778281926; x=1778886726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nnbu4qTvY6NB+P0/6X2z8nimAgju94X8lj1wzzY6I5U=;
        b=FGtYiXjo3Hb8gPz8hni/wimP5PpEEm3o4NYvZAoB5ylLntOXVcLruZi2aKr4gU+SEC
         Wrrc2jPZgSKxy0ju+cOYi2TuwaRr2RqadfLEEW/c6KGSm4yFMvwHvbUgFnCve8O4Z2Bq
         kIZNEj8LSDg4p4nipXhvi8HZQpRO0e2wf3WXXBjrIHZtzwg45pd5GL359QTIpf51sMYZ
         lExvlZ5tZm75fYA4RzMcEvoB0sPbe0hpRRviXzXguGWe1UilA7FzfJ54v6jpKrLidQo/
         Q+MDgFZSkYx2LhdEDIjmj1SvyY9pPb36XqP6Ge/AVOoEdX3sNng/JGubmqjQboUgRnQ2
         /JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281926; x=1778886726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnbu4qTvY6NB+P0/6X2z8nimAgju94X8lj1wzzY6I5U=;
        b=rxcGTHx0aFTkoXcNx7uYn1YYJwXvmmqUhZ+uAIlze6Iixhst3aSa8jbSDpWGZTpnMr
         f+PO4n0pM0kr9JMvosDYNNDu9gbDWkQGUpddEdQdHHIrq3ISeU2zf6OCE0l613KQwUkR
         dY7HYY/RzH1aTwEmxP5370rgGDITGTVNP8QgWtAZVWjsm6XmhC5eZ5ejcR5yPlV9Xtf3
         Q13f875bmxPJr8OBFtFUq7Wli5YDKBi78ZOEI1IbGrgoZDp7yZNS23MOQsYjyhkGw2LV
         4JA0je5WTgGcmFpqUF6GDJardDBMRU5QsvI19wCEwBXD9+ZrEoGpGWMJh/KO0yQJu24k
         cD7w==
X-Forwarded-Encrypted: i=1; AFNElJ8nR5aRC7Yrw8ZJTlIYseqoPQmTf9JMIGvnBYhIWId7lcsXqM9R7E9y3O9ZFD1aGFBa9eknf2Pq9sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi8WEbUi2qXyHz/V8AzbfR11QWsrxQboSG/7wHmmwqXlD8NAsZ
	CDAptsT2FwSP6/pH91J4axa3sBt/rnvMKbbvcvdo7+DfsMAEDLDy9SAk
X-Gm-Gg: AeBDietsDeca6q/UoLUwOD8pAa55le0odsMvLQ8KvGg3QF4G+FDZpDASzho35s551Ge
	fHax9Qda3IXZ2TuOI7bTTlFaiBfn54cj7Q0q39Jr8K1SqUjHrH+traZTvUBA0RPz7RwFffavERE
	A4l+bFbQ4WLSs6GFJpTdgGggDlOklkgPvim+VJWIY+dYvLgaigcvl+ofz/+S6w9RHNXxj5cOND2
	ELBT4gZEmZkG+lAu39KXG26uJPQPuAlRP/vhN/i8kE/VwELJobZMMZ2ebhuGLPlpqohmoLUVoRa
	B1190lrYVzOGSHKn2wRztEv6Poq5pPBpgDQP9BEy6g1QwGMLd5EHRVjzXpAst+TPt9CrWTyQv0A
	VZf/x56b0BYvQQXMpgvJBTKwtqs5HiTpiFaB9illqHGOaxo1wd/xRVtNtwiS1JGiCI5p9foMNKG
	Ea/d7n1lNb7gHXBrS8fTSNNsMIEIdGGsvgG6vn3W8PlfygmfkbYoiQe9NkgCUswYAUew==
X-Received: by 2002:a05:701b:2204:b0:132:7ab5:6cb6 with SMTP id a92af1059eb24-1327ab56dd4mr1421565c88.2.1778281925572;
        Fri, 08 May 2026 16:12:05 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1329fc4bf3fsm972554c88.5.2026.05.08.16.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 16:12:04 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2 0/1] dt-bindings: iio: adc: add AD7816/AD7817/AD7818 binding
Date: Fri,  8 May 2026 23:11:46 +0000
Message-Id: <20260508231147.77044-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Fix commit message to match binding requirements

Hungyu Lin (1):
  dt-bindings: iio: adc: add AD7816/AD7817/AD7818 binding

 .../bindings/iio/adc/adi,ad7816.yaml          | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml

-- 
2.34.1

