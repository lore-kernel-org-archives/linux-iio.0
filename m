Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BB23C10A1;
	Sun,  6 Sep 2026 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666639; cv=none; b=LQhv8HQ6C+rcOKx2lj2yASpfArvChSA3bWJpuFhFGq7uyqdpdZbKTWLdxagiLxWFGlwg0BALb9uu2HCuRv9C+x9bZ3C9FeCCcBhSrmNVkq5xDBp9OYp6wPGICcRZG58VT7hp+RNMaLqJAIKF+LbVHxX7BGurssX+yuStZDkieew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666639; c=relaxed/simple;
	bh=EtOt14Sbm9D8SJJIrrYc8zFHSSIiho6s0bOjEG5CcpQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=VTMhH1/a1o7pd6sBjhS4MGEzMUstIevn1QwndUpRSAWKPnBpAWJL3K36hN6x9CWPRCjE0FgJ53cZzN5YoaQEwYYcvZFzgVZ8xoZcGZ8VYrxdCLEIQLVrlNawf8Qohrwz24/qNGzCS/9uo1Ii4G4Yzihzw0EtCrlXlk12qzk9pfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt1WAJ21; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt1WAJ21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78871F0155A;
	Sun,  6 Sep 2026 03:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788666632;
	bh=2mLgf7VSppvnY3ni5Vo2XFM72n2PiOSLS7vbqcFPF24=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Nt1WAJ21PWCEAAhbVWQyzno6vhC8FfbyKv/3VRIDXkQELRYuSnz59opzFqOKaamxu
	 9gOpQmsMeWNws1PvKCeO5q28jOwqg8RYcnEnDP2tvpd3CCLU0K2j/WGPiIl7+KnbQx
	 XtbmxGfVw8y4YPKr6PSPHjenFNfeC+x8wH7Y1HZ8vCbObGDF22KU5mko9uoWGzwTQt
	 LQYKkzm0jl2TukPIkTIttYQ9ONBNcMhCtNkXNZg8fFSm0VSRUpHKkQN0NWTev1+fSC
	 68EPhMTgr7ZXIoq1PnDzO0sDU5IZy4mMTwm4XsLKL3TsFqU4t9v0O7AJxeHCv4td+3
	 uYiJX0do+IVyQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 17/17] Documentation: iio: Add AD7768 Documentation
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
In-Reply-To: <20260904-ad7768-driver-v6-17-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
 <20260904-ad7768-driver-v6-17-e4378f946bfb@analog.com>
Date: Sun, 06 Sep 2026 04:50:02 +0100
Message-Id: <178866660281.3402141.14342967641787130617.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=977;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=EtOt14Sbm9D8SJJIrrYc8zFHSSIiho6s0bOjEG5CcpQ=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnOL+q8JJ7MSUPclBAop+QWp09ndYj/XvU/6Nn
 sREPg9gKACJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapzi/hEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiK5YEACADh4H86YF1XZ0UVb9BvIq8s3lOe2MEcybmPD2pzEhf4r
 2TkPRL22a+gyi/D+qLJAmDRNlEtz3jwrHcVsePgqsTaykKLJWa9dhx+CJTvQ/PHzqPLySKv1v4O
 BHsvgMRNZ2ncleEAeTdHPgSzuf8a1an79UoSi/SE7DMcwJKIcJ8ht+n2YJwqLeokfMW5G9L3ek6
 aDRWyA7zOzVnC0NeHJSjYz8fI0rqUEnGI7yqorhMq36me927OJhJjtmjEFgW5owLLWob5rVqEDp
 FBsCN/JDb/cCExy6mHZ/QAmy2yAGBw4fJJ2nR/g+5tVuZqTfgDvpiVzjIBNkCAqoEoeq5sBn44I
 x+PqgmLYPpoJp9JDGbmQMltfUpkWQZT+SyNGDbhp5qPXrSkO5McYQfoLbKg9l7bKc/M75E09bpb
 BcZyuOLPrzUinLXELQ0KcicPC+q3Scj6ZTjA3KqIGIVo0VE0zy5d1K1Rw2ijm2p7Jc+r/9VyCcf
 XWsQeswsTwp2Qik/Vt96iiS/+8hz0e4XFkgtTpVNWsZi0MK4LJBpuSGrX2H9YGxaM3e3KBxne9R
 OOZEx3AovlLpS+Bb6jJ4anbG1xPXaBcCc8Fyt9zUmns3O/ySme9gPM5YzRazGffYooSrXgTS23I
 EqKUphSHrrKXNrXZC7qUM0KjZ29NxGbS36fH6lQ==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add driver documentation for AD7768.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>
> diff --git a/Documentation/iio/ad7768.rst b/Documentation/iio/ad7768.rst
> new file mode 100644
> index 000000000000..49aeff27b00a
> --- /dev/null

...

> +
> +Channel modes
> +^^^^^^^^^^^^^
> +
> +* **Mode A** - First set of filter and decimation settings
> +* **Mode B** - Second set of filter and decimation settings
> +
> +The hardware provides two mode profiles (A and B), each holding one
> +(frequency, filter) combination. When buffered capture is started,
> +enabled channels are grouped by their configured (frequency, filter)
> +pair. Up to two distinct groups are supported; the driver automatically
> +assigns each group to a mode slot and programs the hardware accordingly.

Say what happens if the user tries to use more sets of settings and
hence two groups isn't enough.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
