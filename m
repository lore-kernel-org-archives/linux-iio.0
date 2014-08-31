Return-Path: <Naidu.Tellapati@imgtec.com>
From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>
Subject: pushing SOC specific Trigger provider driver to upstream kernel
Date: Sun, 31 Aug 2014 14:50:17 +0000
Message-ID: <27E62D98F903554192E3C13AFCC91C3C2B778F57@hbmail01.hb.imgtec.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Mr. Jonathan and all,=0A=
=0A=
My name is Naidu Tellapati from India. I work for Imagination Technologies,=
 India. Thanks in advance for your help in this regard.=0A=
=0A=
After going through some of the emails in the Linux-IIO email archive, we h=
ave taken the following approach to implement our Linux IIO based ADC drive=
r.=0A=
=0A=
We are planning to have two drivers as part of our implementation.=0A=
=0A=
1. Timer's Periodic Interrupt Trigger Provider IIO driver (This driver uses=
 our SOC specific Timer's periodic interrupt)=0A=
=0A=
2. The generic IIO ADC driver (This ADC driver uses the periodic Timer Inte=
rrupt Trigger provided by the above driver)=0A=
=0A=
The plan is to push both the drivers upstream to kernel.org. Now please sug=
gest us, do you consider SOC specific Trigger Provider driver as well for p=
ushing upstream to kernel.org ?=0A=
=0A=
=0A=
Thanks in advance,=0A=
=0A=
Regards,=0A=
Naidu.=0A=
=0A=
=0A=
=0A=
