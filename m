Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F8383991
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643633; cv=none; b=Jtb0awVJjnk9JC8vD2HVF8+/xfY/gixLMwWNTQduVPtLvzJP02WmvtZ9UagyLpdRVU8jZYGe085lxB7KDN8br5lQq+BXSAToYBFuESAub1oar57rV87+do0Z2Z4lOBumhru1cvmiNfSZC0bBYOiA8rm8A95+L4kNaDaazynGwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643633; c=relaxed/simple;
	bh=9oxU/ojBDIRwPMUG0/SjTZL7qNAw9PZxoYod7z1hHFc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:In-Reply-To:Subject:
	 From:To:References; b=YAnFnST8kBfTJYaxJjfq+f0oMJb6Xxs1FWEJRgroLblO2wR/P45vYsRlVD7w657CbOHjIqClsxmOC0roWzhpynewvKRkcfcXFhcc+6jO67OQ8q0jQ0pKfamgC2HreTdmsydCKQCfFR9QWXvmVQBH3t5IuqJTiFSTHZVrJ+2vxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=B4yhmf3W; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=UyVaqn/t; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="B4yhmf3W";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="UyVaqn/t"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=B4yhmf3WlXuFXJcdirCyd1BAKuC0wWktpmBhdZ9JaiBzdf2w7BRlRrBcV1N9aOTedKJWmgBcDluB9FEB1ayIihUWzA/Cx2Mq17mflf6gdjDLNuqtdaMaNoiMCf+2jlgX+fGzANZaPw2ky8POiRl2PlWhsDBI2fKqPc7ANvn3Gf/0TfhC47DDTqGUuZvO0c1cyWbQ3HjRLfc14xhNE4DDkA/FAQ5H3bKOUudkkk3EWT84qQiIgGmtAtp29CDOhLjW8Sm5GQMfpKZJ/5fBQDA9cizaNUSBThZUrSgABvp0hW6i0+llM99dqPU+5qiapCjHz1hslm87QD7slAuu6A9j9A==; s=purelymail3; d=maxwelld.cc; v=1; bh=9oxU/ojBDIRwPMUG0/SjTZL7qNAw9PZxoYod7z1hHFc=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=UyVaqn/tjxCOF7LcA4BMlEBm8Qevs5rNdMAADzL6xmx6dUhYjyiFCTrk4ig8qXIgFFOJAxWUeLkgD2sTVSK3h22QiaRpYBfZvkGV9zC+guqss5Wqa2ASDf7BdQl5xgUysZzpm4/7Onw0YucaEKSJCuw4nDHMjlE6YnYSmpJ8qn01/UUNVp6ZXBIlla9dQic8Ie82Dj9RxVR11fPcIQOqnLRVsoRcDQk+1pE/CbYjAytETVcYbOMy+nUNHqwxoUrX2T6KK9yQGanYGJH5XEkt3wqxXfcaKcXYiBcoqCK3mr0AEeQzoGjk8tHNA/NPaaF77EgYwGyVpQ26/5Ulu1AJkA==; s=purelymail3; d=purelymail.com; v=1; bh=9oxU/ojBDIRwPMUG0/SjTZL7qNAw9PZxoYod7z1hHFc=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1985454291;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 13 Aug 2026 17:53:37 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 12:53:36 -0500
Message-Id: <DKO0AYIQQUJ1.3G9V8W1BY75Y3@maxwelld.cc>
Cc: "Marius Cristea" <marius.cristea@microchip.com>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Tomasz Duszynski"
 <tduszyns@gmail.com>, "Jean-Baptiste Maneyrol"
 <jean-baptiste.maneyrol@tdk.com>
In-Reply-To: <20260813071912.2465208-4-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 3/4] iio: chemical: sps30: Unshadow error codes in
 ->store()
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, "Jonathan
 Cameron" <jic23@kernel.org>, "Maxwell Doose" <maxwell@maxwelld.cc>, "Sakari
 Ailus" <sakari.ailus@linux.intel.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
 <20260813071912.2465208-4-andriy.shevchenko@linux.intel.com>

On Thu Aug 13, 2026 at 2:16 AM CDT
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> kstrtox() may return different error codes.
>
> Unshadow them in the ->store() callback to give better error report.
>
> While at it, add missing kstrtox.h inclusion.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/chemical/sps30.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>

Reviewed-by: Maxwell Doose <maxwell@maxwelld.cc>

thanks,
max
