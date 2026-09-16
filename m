Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A4146A66;
	Wed, 16 Sep 2026 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789537779; cv=none; b=kIg5Kloa/rN50rdRj13lFkL0o3Yn+ny14rcJfDH5S+D4JAdKz40pKz9zp+05AjV9VW7D0HVJUBp+qYTr3LefjYL2sWRzR3Q06LNHYW7iHC1A9epR3oxRMnesuzGEXV/UYA93T2m/pf5PN/Wp3jdiVneqe6vsucnZOlKck+O/+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789537779; c=relaxed/simple;
	bh=jeuhy1iSsZy4MhHBaH8+S0uwh03Y4PJkKzT6BLizY+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMJIIA5Ca5I2nmIRmjxBLEjDun6PP5j7BwHW5ydt6ifQgcrDbEJhI+Ch1hjLmScorlyFHIPNoOebWW91i0pSBm8iYLoSJVXaLd+1mxWavyqvIwtlDuoPItyGpEbh9fjMIPXHNQnrQVn1XVlI/HiYkChBRbNEMHsjxDELuUsZ5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vh2dW0Wq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vh2dW0Wq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=O9SuEdt/eXEhTwvxh7cDDTs5tMOZ9Xs65h3KXpjyOEU=; b=Vh2dW0WqFvXwtAsbpRkoSe4MQ9
	hB2ZOmxotK+6ClX5UeR3/6FXjiAVTZHVpkBzox1s4GG7LDoIh3K1TwN+iTF+aoJ8GFxAcJ8DzWio6
	oh++hpDE7Dicaeru0peZlgmwZ7uHER6aJH6fda7lI7KdoisA91t5yYp8XnVDvdPCc5whtOXnC+oMx
	GpcCSYRQethZQW1FnmZw3C7cfpCJvBBWKZKDnLCYH4PNUZIBqSVJdl7ajSrNJ6RAKLusxs0ZHdZ/J
	KXT2RHahSGrIp9WRJvk3LV8AoBnnI65iVnCGJsa+UDaTs04FQBcfbzlAzfwrEbXbomsWIdUjTO3od
	zn5HFEQA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6iWM-00000008PmL-3ASU;
	Wed, 16 Sep 2026 05:49:26 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs: iio: backend: use literal block for commands
Date: Tue, 15 Sep 2026 22:49:24 -0700
Message-ID: <20260916054924.2052572-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use literal blocks for 'cat' and 'echo' commands to separate them from
the surrounding text. Otherwise the lines run together, without any
clear break before or after the commands.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Nuno Sa <nuno.sa@analog.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 Documentation/ABI/testing/debugfs-iio-backend |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-next-20260914.orig/Documentation/ABI/testing/debugfs-iio-backend
+++ linux-next-20260914/Documentation/ABI/testing/debugfs-iio-backend
@@ -8,13 +8,13 @@ What:		/sys/kernel/debug/iio/iio:deviceX
 KernelVersion:	6.11
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Directly access the registers of backend Y. Typical usage is:
+		Directly access the registers of backend Y. Typical usage is::
 
-		Reading address 0x50
-		echo 0x50 > direct_reg_access
-		cat direct_reg_access
+		  Reading address 0x50
+		  echo 0x50 > direct_reg_access
+		  cat direct_reg_access
 
-		Writing address 0x50
-		echo 0x50 0x3 > direct_reg_access
-		//readback address 0x50
-		cat direct_reg_access
+		  Writing address 0x50
+		  echo 0x50 0x3 > direct_reg_access
+		  //readback address 0x50
+		  cat direct_reg_access
