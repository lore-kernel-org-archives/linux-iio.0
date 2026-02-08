Received: from hosting4.idealhosting.org (hosting4.idealhosting.org [185.87.26.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5C822F01
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.87.26.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770536441; cv=none; b=pdhkDA+jXas06ThfG4WGpGufhJj9jFBgINsNi8wRDOI/Ji8D+k9k4Oq6NLNHkeh5mHmg+V6PyRSkF5RhZOkNsV1Pj2ISmzJnd32ozObg3Dy2jkLq7sy6X5mwJ0ZAQSM7N/QYJc/HpQ7HkH3R832AIzV4xrdWJbGF8BtxjJHWzVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770536441; c=relaxed/simple;
	bh=JExkBDb+FhnDhbnHIRgecQ7xFnq9d0/tC0z32LDSHDY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aMOZsuG1WVs4OBQWBplQDC6FCPM/y8218sAUN/YQFMR63gZJ3+yjbc9Kxu9DeWLQs4HPdPpIwHZ7B79/EC/uS/TxRoX0S7sdyVd8Y2eO2v+6lsyk2P19PBJVO+v1mfj+kQG3eb9kSQ5gEINckfLB6BhsAOy/Ulkqqc+1kZqu/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=investurk.com.tr; spf=fail smtp.mailfrom=investurk.com.tr; dkim=pass (2048-bit key) header.d=investurk.com.tr header.i=@investurk.com.tr header.b=BUq/DBXl; arc=none smtp.client-ip=185.87.26.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=investurk.com.tr
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=investurk.com.tr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=investurk.com.tr header.i=@investurk.com.tr header.b="BUq/DBXl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=investurk.com.tr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JExkBDb+FhnDhbnHIRgecQ7xFnq9d0/tC0z32LDSHDY=; b=BUq/DBXlcb/aV7vXyNce6tioQ2
	KS6shbdErdOxuaj5FcB6sOmD4+ROF6AdPwv/sD3e0+qsUgQESWb5NPJUnAVZZj2RGxSgPwpSoLiGR
	ExjTkftjXiu7bIk1TGiPvOMItDFQyklHAKoWbhbO14Yo97PAiySEYc+6tmIe7gufipJB1Gg+KOLOz
	jfZWuflPV8vOqwdkkTEH8ZQ6iOMRMxtUWZwAnshrFrdWZb4Jng1sdLMzPBuSLdyMDsExv+jIqAvjZ
	NJk+qHABsrs8rxC8pYmLvDKR1mVO5JdhG4qs15bYAH5VBPyf8hJyxvMvrldjDgNfGwcpJe+j0KkjL
	NXKh/zdQ==;
Received: from [130.131.125.197] (port=57707)
	by hosting4.idealhosting.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <emreaydin@investurk.com.tr>)
	id 1vozPB-008RWV-2U
	for linux-iio@vger.kernel.org;
	Sun, 08 Feb 2026 10:40:30 +0300
Reply-To: mrdhakergnaba@centfinancialslt.com
From: emreaydin@investurk.com.tr
To: linux-iio@vger.kernel.org
Subject: 2.5% Interest Rate financing
Date: 8 Feb 2026 07:40:30 +0000
Message-ID: <20260208074030.25C22A694BA8393C@investurk.com.tr>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting4.idealhosting.org
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - investurk.com.tr
X-Get-Message-Sender-Via: hosting4.idealhosting.org: authenticated_id: emreaydin@investurk.com.tr
X-Authenticated-Sender: hosting4.idealhosting.org: emreaydin@investurk.com.tr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Dear Sir/Madam,

Warm greetings from Cent Financial Solution LLC.

We would be pleased to hear from you should you or your client
have a viable project requiring funding. Please feel free to
contact us to discuss potential opportunities for collaboration.

Yours sincerely,

Mr. Dhaker Gnaba
Director
Cent Financial Solution LLC
