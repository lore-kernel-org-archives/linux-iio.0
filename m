Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D713A640C;
	Fri, 18 Sep 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738888; cv=none; b=EmVVcZ8kG1XS+PaTkuO4qE2AgPt+RkZ0dZSfF/Di7uktX7Pi+pyZhYjCSvedygyLgy4JEJIZqJ8uSzEsQzG01GSz5HbmM1v/E8sqt04HQE5T+1wHxkzkCzjvSjTM+8XtiMdQlCaAfHJZ4BqhFgZWiPvKZ+AJP6OoNknlOqh+A0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738888; c=relaxed/simple;
	bh=Xkj5A2J4GXljEZhq40PbBIQdQqDqbwrWjR4fc9OHuSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NvvReVPuJykPgBjsynHwwtyvKNDuu7evOu6lsn1nyC97dNQjOrFOTHCTpA8s5SdSeET0jwKvJ/bCdrNrKqhRgPMXrnAaRoANmAAYt0qWJpQKt/hNXB20iWqn8ajPcrhNXH7aAhRisFE0KDIulpWXlieuGKTpUTO4FjVy0wqOPzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=d5qAWhJS; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="d5qAWhJS"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 68IDetRv029419-68IDetRx029419
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 18 Sep 2026 16:40:55 +0300
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1x7Ypj-007NlL-FJ;
	Fri, 18 Sep 2026 16:40:55 +0300
Received: from lorpotin (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 16:40:55 +0300
From: Jaakko Koivisto <jmatko@utu.fi>
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jaakko
 Koivisto <jmatko@utu.fi>
Subject: [PATCH 0/3] iio: chemical: sgp40: Add secondary chip functionality
Date: Fri, 18 Sep 2026 16:40:16 +0300
Message-ID: <20260918134019.1101308-1-jmatko@utu.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-16.utu.fi (130.232.247.56) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhZXkgJAygB
 HEUDBAEGDw0aRgwNSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEhaWUgM
 BA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVBIBh0GB0YbCSgJBgkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=a1zQYLcKNhBxW8nUp43fyPq+++ctjjF6EWa2BcXJtIk=;
 b=d5qAWhJSpPCJZFRSmxywfkj//71nOLCR6s8Rixl5clTC9MTdm+J5PayCeT4LuQhD0+wIU/poQIwP
	LFUf6U8wCqHBIP2XeEU3KTCrzvMtpbq+nOGqoVwDGK7mfKU4MUDbx+eMgtoS7B/QFRMd/2Egszp1
	VsZ2imWQLHJHE8PmRyPG42FOvjIO2uHcXjwuNx9U3aTyGOPgwTHSdEp8CcEQgtvH75aydLOuo3Sa
	VWrMlYftk7EdU6FgyMH/4zqHhzgQXaLmfW8vsc5b6Ppq9urbpw8B6c0Sa2R2jiKt90uPsqHCsAj0
	ba1A8WHzt0eRUpwVJEgrJ9mhXtqfA2sy8A3CqA==

Add functions for getting Sensirion SGP40 VOC sensor serial number,
running self-test, and turning the heating element off.

Tested with adafruit SGP40 and waveshare SGP40 breakout boards using
Raspberry Pi 3 and Raspberry Pi 1.

Jaakko Koivisto (3):
  iio: chemical: sgp40: Implement get_serial_number-command
  iio: chemical: sgp40: Implement execute_self_test-command
  iio: chemical: sgp40: Implement turn_heater_off-command

 drivers/iio/chemical/sgp40.c | 159 ++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 2 deletions(-)

-- 
2.55.0

