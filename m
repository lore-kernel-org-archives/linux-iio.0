Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076DD4A6CDA;
	Wed, 16 Sep 2026 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582081; cv=none; b=myWM9T+sYX/JROYi7z2tw5hwpt6rOuhzJ1PDv61HS/xgMsYe86odvuamJfXbPaTJ5aQb2AO1DNVtIl6eSdroaUBxWWzl1P1R4/kfypgi8gd1VB/GRXZwEJ3mrFHilBEj3+1Iggx85M8XBJ6ZL2KCDrbrK0ysubPOIQMoV9PyTns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582081; c=relaxed/simple;
	bh=50iVSfhRqAD+YCFjlSnQby2mJOK4r7s27lrWKtiauyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqsFHnQsNOqUJU+Le0PFS+h/gxTDtgOiwMiPhZYjmqzE6nLVdm4Mr+oEAuIxIqbAfWVKU2CBXLyX2DA9JEN4ZmGYXM8BgYSeEj7Hh0ABhHco6F9z2yhbfyQTVrF/FAl/g98n/LqUL16UAbG4tTfZQ1B3ouf/usN+qNAHlUU3gNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NxHjYLnv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NxHjYLnv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DbUbIYfn8QtnnEUK0/3MDj4t1bTMrqE+hmCt+aGQeNA=; b=NxHjYLnv8h1dedXo39llrxCSNE
	wvxxS7oG1blqk11EfWADC17tsvA2EP+HHxKu1USWn6ih29gn1EkwIMJAgDOhN3dTVDDPV4LwgpHNY
	32GSoOoocJogjp6jxdsHZP1dgAAFm0KFJDHT2Rk7MI5DyROnZTD2pREZFpv1oyAGJL3+BrDVFYX2j
	OZuEiHVbHWzb3lQlUiEjdhdzz0Ibn+XC/PXrsA0JeOeLSdIhIFCLuK+OaFVEl0pkDd5hvYQWPWqMW
	PfBDj5BY+HY3iwEFycf6OzFgUAeuvk8RAfJAVSoxxaIRf45mvXChWqAdQgA54tNDiIQhPYP7201fk
	u0ep1SSw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6u2m-00000009vax-04Vl;
	Wed, 16 Sep 2026 18:07:40 +0000
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
Subject: [PATCH v2] docs: iio: backend: use literal block for commands
Date: Wed, 16 Sep 2026 11:07:39 -0700
Message-ID: <20260916180739.2296401-1-rdunlap@infradead.org>
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

Use shell comment style to go along with the shell commands.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: use shell comment style (Andy)

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
+		  # Reading address 0x50
+		  echo 0x50 > direct_reg_access
+		  cat direct_reg_access
 
-		Writing address 0x50
-		echo 0x50 0x3 > direct_reg_access
-		//readback address 0x50
-		cat direct_reg_access
+		  # Writing address 0x50
+		  echo 0x50 0x3 > direct_reg_access
+		  # readback address 0x50
+		  cat direct_reg_access
