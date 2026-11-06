Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969791;
	b=RhCHonKHzJGzNp1BymdskolteArtFfwShkga6WoaKvoz/fEqX2xrp2Po+5LJMldnk5Be
	 1k797LKFh9qJvxTupbcihSel2Ab2XUG6HAOlOGopplqcCgepqCylb/nR2tHXNYN4PfdCZ
	 4ufwRTkEBEkvTKam8O9EatRlRXi6QDDJM4JAHJePDlsMofQfe2SY4O69BtoSSbxb9UcG2
	 SbyPneccyPeWkQushbdVfugvb/qBbxqmQeTA2otwCtzODYVhZ/NKXNa9ebg5TNMdQnca3
	 9OXeHseQY0ukl0cnhw2sdxYDDht/Xz+FSKqGuDQ+bq9CcaS6nkJ6BZb8AIFwOMj9/KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969791;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=uc/IN5ZxRNLWtOlGpNhN7ykeBmqHU8+hng6fKxqEKd4=;
	b=mysXuUrVnv5LdzBs7oPBGx/ucsrMJLnlYuUf4OivKlXPVtnSxx2NM0mal/rZipAxEU9l
	 TN9EUekuwQOiX84QeUnSLUJZ2DebJ0/s/IbrPJrkpXZhSB1OYV4rbHmvEKuT8CdwmXpVq
	 xz4S9/mHHT3gxc+UaYD4j/sEEiq4dg5V8jbyVlVaTjaHO8Sx4e6oOZ7kikKqRytEmLqDV
	 Hy1K97UGWpBsvhWHC4E8PRuKnJY45xXrTVDya0BHzhc9Vyj5IxvlK03t4vJT7qTIfcTIO
	 D7GfmMn46gzgfyEJihtEUx0vBPW+dZVAxonvP3q5zwim6ey/dnzFPpGCx8VlBdO0ibg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=N9jy4fab;
	arc=none smtp.remote-ip=79.135.106.117
Received: from mail-106117.protonmail.ch (mail-106117.protonmail.ch [79.135.106.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B6606A32E;
	Fri,  6 Nov 2026 12:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 685B6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=N9jy4fab
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1793969789; x=1794228989;
	bh=uc/IN5ZxRNLWtOlGpNhN7ykeBmqHU8+hng6fKxqEKd4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N9jy4fab1bnDuWFfwgGJ08cq45CjJoPAtwBgNDGK7qmm1snnH1zBjGyjj7uYzW6uZ
	 SO2lpkTOavxNmSSShppy0VG+NRkoryx1IWnmO92k6mrCuyWN/UHY1u0667FDd+QQ/9
	 gQMccwTL0H3ElwaVzfJ7yXBiH0ZMZNyLo26HH/7IMS1NQ71YVf+iQ6DAYcLjV5+hGN
	 1FL8iFRfd8eKpJiL44MOUeT7ou1Lj0jpZemfNyXJWJv9eFdGR9hzCkxa7rhAvUXPlj
	 yUK4/JiA8X1q6JQLasCZDtoKCy+iIfJ/RXxqOnUJV+L/OFnDl2fk+2Vlk4aW+6tAaH
	 pDhFKuD+BC2cA==
Date: Fri, 06 Nov 2026 12:56:25 +0000
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: sensor: custom: Fix use-after-free when the node is open across removal
Message-ID: <20261106125618.2898901-1-ca@modelmiser.com>
In-Reply-To: <20261106124914.2892604-1-ca@modelmiser.com>
References: <20261106124914.2892604-1-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: e8091c78ff6739ed99471b51e4cc466983628253
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Please drop both patches of this series. Srinivas posted the same fixes
on Nov 4 in "[PATCH v2 0/7] HID: sensor: custom: use-after-freec after
remove": his 4/7 takes the same refcount-and-removed-flag approach as
1/2 here, his 2/7 is identical to 2/2, and his 1/7 also synchronizes
hub callback removal with raw events. I missed it before sending.
Sorry for the noise.

