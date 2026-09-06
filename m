Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9F2DF717;
	Sun,  6 Sep 2026 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666627; cv=none; b=BiGNe/gFV0tqRWvAGMyVn/if+JPeJKz3kwvNsxgl0h/EPaM8VegZjrerF+zRiR6CvUgNUtCz/d0y7MKMYtArTK3up5C7xdj8dZzBdF5FhegZ4Mk5/T++VDOqHw/4VawcWEm4KCGmQOLeuCbl5H4S2kUH8+aFfdkyej+f2ASg2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666627; c=relaxed/simple;
	bh=IZnY/XTRrQnOrn0nQjoU92J3CgS9YD8QZKy+NsGfeCM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=PPUrmrNCGrAoGdUHmyUp6NeQwCaUYiEmxzGrKzv3SsI0juKakP8Iy3m8DrbJ6AFj5pEL2fxyB6KH8o5gZ5X0nBo+E36h8gNJK7m2D57u63mkH9r2EbBaoXJN/zmTTVk4yQaS1u5s5YWYnslqi3o/NUjPtdarjvLmKlwEX2owJig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrRh293l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrRh293l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2BE1F00A3A;
	Sun,  6 Sep 2026 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788666625;
	bh=/FVxwLByr2fbsd15tp0aSyHlbFN1N6YltOFpZYUQGHA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=GrRh293lB5Fhl+8bOwnLznpZsIaKXWyvSqZqtPAmP0nYHye00aYQUPyBGD1dRY9fx
	 2/S29j+G6H4LfvNh1Q2HFzoe3UROFPYXQywGdPTTYX6I/+TsaE9nStzIDQPYxXoHm5
	 Hfcn6KXaQ6vjHiQbq/5bJJZv/2Fu6UowWpNcrNteF2XUcnV5JnI9ZcNlldSdUPeq+B
	 a9pMpffVzrco4HYn0WyU7YTS92F7OcRqveXKoCPROySg+lHTzSY4RlvlotMiq+btzh
	 sm5eO+qv985AY0wQ14Q2sAIz7dwDPM+ejVujAvC5tlgGZRqc0MOnTAVcXiBpPCxqFX
	 WU2AM1GCVWGuA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 03/17] iio: backend: Add support for CRC
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
In-Reply-To: <20260904-ad7768-driver-v6-3-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
 <20260904-ad7768-driver-v6-3-e4378f946bfb@analog.com>
Date: Sun, 06 Sep 2026 04:50:02 +0100
Message-Id: <178866660276.3402141.14172421662312335123.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=584;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=IZnY/XTRrQnOrn0nQjoU92J3CgS9YD8QZKy+NsGfeCM=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnOLv7Hx5n7x8DTOG5rlW6QNp3iUSDlRdBQ/bp
 +y2MQsmE+OJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapzi7xEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiK+DD/432gZSN4K7YEEfqH9ZVMc2stEJvXBjpA4mo0teukNxtVR
 YkbcYfcS6yV2zwSN5T5Zx1seX+f6SaO0x+2prfVryTsTQnkQVdAz6AkCnB+HbBfNTIdJpD/ybi6
 8HUtx1tqiaGFKF7L4+fn66q91bG87+nKz7ajY+G1BbmoW/o+892TLI+Il4akAQ8PiZUxW0iWM8c
 c1sqwAjv585FQ9/lW9OjxH97FT9rFF9ONx7AGNBTcdzfZa6jVDJeE74Ht98Nrhl8PXGwGm/G+mh
 kOqDt/83WattaEEIdoOPE1VKA/FZTHIvDYK+Tq0D98iOR7zSb9KIKm5ugVC3CShyhybLP+mGqRL
 BmrPlODYcS0jUt8qkDfAIOnhmZWc+Yzu/4VeXNGmlnsXVQ24C7x34AlPWFAJcM2bHUJn0Nxxz98
 zSAkwaz13EpGlVrbT/oayCejNRqkogzoRSF82P/5caPYuEo8mFQW+9AjWQDt26fC4XTuE0R0xFe
 lr8tvnrJ+kWOjfCU0cW5v/Qz9zLOD1KTQ1Vh0Y2VWBGdNS2uzZUSK00QvY/ZNoABJUxVY6dCUcL
 yTPzBde0UUuyGBkrxWKhU5aRjIDJRVfUR0GiCUQbBui8acYlvlKVZXssqcfeO+gngFz1hLIG28C
 nsPDaZDkXi0VMtg37UikusKFDfd/ZkmcoVoaHJQ==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add a backend operation to enable or disable direction-specific CRC
> handling. On input data paths, the backend handles CRC data generated by
> the frontend. On output data paths, the backend generates CRC data for
> the frontend to verify.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
Looks fine to me, but like all backend stuff I'm looking for a tag
from Nuno to ensure this is inline with general approach to new
features etc.

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
