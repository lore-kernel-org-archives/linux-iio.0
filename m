Return-Path: <SRS0=HEZw=JW=i2se.com=stefan.wahren@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
 Denis Ciocca <denis.ciocca@st.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: st_accel: iis328dq support?
Message-ID: <2bac9ecf-9d2e-967e-9020-1c950487d781@i2se.com>
Date: Fri, 6 Jul 2018 09:18:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,
i want to use the ST IIS328DQ [1] on a ARM board with Linux. The iio 
subsystem has this st_accel driver. But i didn't find any reference to 
the IIS328DQ, so i started comparing the datasheets and found the ST 
LIS331DLH [2].

Since i didn't have the hardware yet, i've the following questions:

Does the st_accel driver support the IIS328DQ?
Should i choose the st,lis331dlh compatible for devicetree?

Thanks in advance
Stefan

[1] - https://www.st.com/resource/en/datasheet/iis328dq.pdf
[2] - https://www.st.com/resource/en/datasheet/cd00213470.pdf
