Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663BD42EECC
	for <linux-iio@vger.kernel.org>; Thu,  5 Feb 2026 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307260; cv=none; b=q/Bmr3vonFU6THkzOYzl0qjkbwzh0kWVoTw8TFS09XlqNpeq0bUGnKatxZdm/GNXAi9yztjCBLU5N/5TiS0iKDnF0kQZgfygV3B4FE/BOptuuOxX8cF75NN/+ufq4bRilaYN7+7gyzvzwYyKjEtrImBayMfOyvUECqqgBoAnHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307260; c=relaxed/simple;
	bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=s5sG8BwR4BO5FxZjZCc/zh8+nmflkHgk+QROqGcO1RML+pKCIs8QenlGjDmOTurBq/stY6R/VAx7sbBH32ovLm++t69PzU5YWqavGxcCIV8LxDCEQLUj8J28gskzoWYLEd4y28XuPjNBJVPz3xEOGfeF2DqVKcpNINx8AXgAoLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qLhvlEBT; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qLhvlEBT"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-948c3ce4d35so730573241.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2026 08:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770307257; x=1770912057; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=qLhvlEBTF7TxhB1L3WbxW//ua5bdPAxYMCiDMKNtk0lb09HuU5pF9zJLLBGVA5LYtW
         tnUjJDNIviqL1VH49SGLyJCbXmeapUxh7wCbQmKwenb9R5iRt8z8xF8L2z/3uqMPBW9p
         0ln7bOgjp32ctMjvec4/V1OdcGuhv34dZ6CdPWLTMc57rzfy1hDJQVIUeY0HpZZynSwN
         3mMvjPQIIgmLq79QA8wjXhr5I65YGFK5NBqUchCzDfRHwpSDjvOkzAJ/QoQJedPWCqji
         8ybOxvU4FjRbD2VV6XB4l4q4PCXce11GTsCWGeEki4frKV9fa1YPRKvW7LfaKFJrojk3
         AKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770307257; x=1770912057;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=e4MVihS13owbBuf6Cn5RB1CILqFptVsOdrVkH9Z5VRIb1jQXdgPGgn0GQRdzuKekuh
         DNyxwyExMLEAkQ93DrmX6ZB6o4m8vsnNNpedguqi4ItHbNXJZl2t+Z/E6aEAMu+ifuQk
         BKJ+IhaXWL5hV+3MvhsSZiOFpZzijwKBJlH1jHyuTMgEOyOClEp7gp+BYXfC5O2sukCU
         88eDSXlQbK6CEcv7EnqjPi3WIqNGFojDkGYwrDTOVP0Znkl6I88BwD9jfY/QFw2F1kBd
         aYFQqXsY7bwE34xUoBizDq/bL4Bzkw7unJSYLNOyAyTaetMHzWMSyNeLGAp8tEUiq1DQ
         ebtg==
X-Gm-Message-State: AOJu0YyGsB0WdpQ+5kPacSs9GR3OcEkIPiUGQC6narzFVL8OteALNDu+
	tSMsphS0Bmj+SHRAjSEakNcNFSsgMPshGo2WiV2WJxFGXourb9yFfuPjcAk1/SW1h2GyJUceux+
	yUEBf
X-Gm-Gg: AZuq6aIxiVBQor2bwE6PRmJ65yFJ8y/jGOQ1/ULaEOjRIRCi7bZatcA2oIo/ysg9t82
	mtKTawfG0K92SjK9yeWabv6t011RKgK2177XD0QSSVw/uyqfkTg4mCDnMfz3u/7T2K9l4wEybj5
	cwJHe3nk+ils8sca4RzUCLAfYPywe+DXfz3sLiOTBUwCVGeh6IVBy9Pm3HAxa1ZKiovg6JRNQ3t
	xs3XlkVOoBrjESQlC7vkO0ccZVUHW1K04KCYnaQXMUyuWFn/jCbwmDhg/HIKE2HAMBazvuaq8qq
	U9ZlUsL465j2hdvTGYldcfmx8v9pDc1N8KF9SpX4nPEd07spt0cJHIbP3k/oFPKmdHnqflhaoWd
	pN9P/YB8FS4N5yNkkHwUEzmBDnrcpFxdjY4J6qD2dqdtfj550BPtTCYbpbq4qVE5Llyy70roX6S
	1F6ZQ8EC98HtGBBz/KgzyNzEaiVt958OWeOUNG816TGY9shVZFKsmgdFdAMwGhWV5F
X-Received: by 2002:a05:6102:d94:b0:5f9:f3d:69a4 with SMTP id ada2fe7eead31-5f9394c38a4mr2632540137.14.1770307256813;
        Thu, 05 Feb 2026 08:00:56 -0800 (PST)
Received: from ?IPV6:2001:1970:3847:e000:1977:be2f:4a71:2892? ([2001:1970:3847:e000:1977:be2f:4a71:2892])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521bff135sm42614656d6.10.2026.02.05.08.00.55
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 08:00:56 -0800 (PST)
Message-ID: <17007dc8-0bd5-45ce-9edb-e53b74e74f47@baylibre.com>
Date: Thu, 5 Feb 2026 11:00:53 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-iio@vger.kernel.org
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: unsubscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

unsubscribe

