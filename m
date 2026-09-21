Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043D2222C5;
	Mon, 21 Sep 2026 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955465; cv=none; b=szlHHB2U/RGFzkXShNKoO/lz9tQyW9n+fWrgN9NQwOkiz53LWKXuxlhC5GeRgFVc/BDj1VL3fAXspAF4ZN6VU/TvGK9YLlMsRXkEpIbgRPhD1P/rXXLXXMww7mSmW6xwZKB5vBsmsA2SRL3rc3RgPtLHkS/TPcs8E2k5wn6E+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955465; c=relaxed/simple;
	bh=q45ScXMIR3sGYoilO2NyXNqKzxuEsK/mYcebXcMkEzo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JPwVEWKKCdQ2q3bHTogB+uGnJbs5xHjry38y+OhkKluoNE327U4LUOMGl++p2JwbnRSAKdwrA0oz9o/lo9taCe5C61Lu1vN2XQXxhXycAQhp6GX2C/E+yJiabYhd3m0KLvy2t/BVrFVs9SIgxE6yjDg1Svc1+fvRXwa41U4xfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/0PBtja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/0PBtja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ACE1F0089C;
	Mon, 21 Sep 2026 01:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789955463;
	bh=3IFgwTPNie4n82+i1nRyK7T60laXK/d6R+mmJjnEsEc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=S/0PBtjaWTRef5SzRuVqiwu72jmXWwojq0mvjracXpmPVw78IpAn2SE/HsNgcdPPY
	 jmLNXFqW2IKpsGZNb8ws2pxFVyQslxF6+STmDqVEdNh96fJNOIEwe9e4JU2syXpCbV
	 76bO4hNb2y71mFf1YKW10x7XB4XkrLlbMFQ/4YXfFeSLx7qjBKnDpZKi72DV+i8LWH
	 ZNz+VEGvdjPCJBDOCPUk+4HW+aqKOgqjqJ0xorQ+CCDy3EqeJRcPPsbYMV30rkqDwn
	 RRMctWJHPbGDmKg6LpiXiV8fomMSPx6g1Y9WXE8AhAaOHGXf6GRBTL5ZRB+TyfMkB/
	 QHBZXZ3KY8M4A==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 02/15] iio: Fix typo in vendor name
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org, 
 nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org, 
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
 marcelo.schmitt1@gmail.com, Andy Shevchenko <andriy.shevchenko@intel.com>
In-Reply-To: <8ba81bb20d92fbfd8e4b7ce80093223fcb8534b0.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
 <8ba81bb20d92fbfd8e4b7ce80093223fcb8534b0.1789494473.git.marcelo.schmitt@analog.com>
Date: Mon, 21 Sep 2026 02:50:45 +0100
Message-Id: <178995544506.955708.15043108946767555978.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=319;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=q45ScXMIR3sGYoilO2NyXNqKzxuEsK/mYcebXcMkEzo=;
 b=owEBfgKB/ZANAwAKAVSFNJnE9BaIAcsmYgBqsI2Ejadhc2mUPl0HKwm9Uqzf9c4vS9XHRUheS
 SmacaWfc5eJAkQEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarCNhBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiPLYD/jkL6URrKWJrfAUviBeU2zhvLm7Ge5QR2hmWuf+zUdtuqu
 mBgq8zh5Hi2trgG3mttKuEO0K0Ja9x7c6GdDDiNrKSc1k06rA3BEH7mm7r6+6+X17yPiCGXHO6g
 gAPipHEuqqGIkF6h2d0RXmnNhoCkgNW/cQtzvnNn1hezcdRLSPha1gLUTUs7RqARiWeMv1EE5G4
 mMH1VrXVQ+IQ3Gzt6SYfrmOZXuKi48o/Omazg03mzhjkuvUs7SOJxjfzpgSoVA7nXHaqbJgP2Wo
 KNvEC6mC0N5lURdL8caQFIpKwJ5sGwOOLscRqynwtkDLpaltphF6FEBR4twKGwpBp1tQw1UZIcV
 dCrkTB3ZND+YxzsYi4nTxrSsPlh+t20pVEIEg9mWdCDDYYmoijNyCuqwa23KSOZMQyCXReXhiRn
 cPGIbDFNyxfw2GOLgh/HDWLYUozPSInCsMu4tZKRmNgIuW5aQqZ3ZhPUKQiHdEyLfaQWZ7NWrnK
 UACBHrdmjwXyoyWkIk0w6KT1kucSH3eYdTaq1yTwHT2Y3dEIsQUKRLKFPPDC7Ksr/vUdm1iW2Pk
 /+LPSIZ0zqXzLOvhs+RYulurMmIZQ0sPjng0MUEjNOSUhYXs9ieIoZ6zt3PFvcrAq2KGMTIoAcG
 5YvGbO0i58cKsFnFEiyBYDYxyp5P0mpJfikUa
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Correct a typo in vendor company name: "Analog Device" -> "Analog Devices".
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Not connected to the rest of the series. Applied

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
