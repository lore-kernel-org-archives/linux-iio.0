Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52223 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbbKRWSa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Nov 2015 17:18:30 -0500
Message-ID: <1447885055.2778.115.camel@spandruv-desk3.jf.intel.com>
Subject: Re: Surface 3 HID parsing errors
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-iio@vger.kernel.org
Date: Wed, 18 Nov 2015 14:17:35 -0800
In-Reply-To: <1447851731.24088.65.camel@hadess.net>
References: <1447851731.24088.65.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2015-11-18 at 14:02 +0100, Bastien Nocera wrote:
> Hey,
> 
Hi,

> In kernel 4.4, the I2C hid layer throws errors when trying to parse the
> report descriptor for the HID sensor hub:
Was it working in 4.3? I gave a test with another device with i2c hid
and 4.4.rc1 that is working. If it was working in 4.3 it will be easy to
find the commit.

Thanks,
Srinivas
> 
> i2c_hid i2c-MSHW0102:00: error in i2c_hid_init_report size:63 / ret_size:3
> 
> I've attached the i2c-hid debug output through dmesg, and the report
> descriptor in this mail. Any ideas?
> 
> Cheers
> 
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 4.4.0-0.rc0.git7.3.fc24.x86_64 (hadess@coal) (gcc version 5.1.1 20150618 (Red Hat 5.1.1-4) (GCC) ) #1 SMP Thu Nov 12 17:51:35 CET 2015
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.4.0-0.rc0.git7.3.fc24.x86_64 root=UUID=6dadcd59-2499-4ac6-8cd2-fdd2c043b52e ro nomodeset rhgb quiet LANG=en_GB.UTF-8 i2c_hid.debug=1
> [    0.000000] x86/fpu: Legacy x87 FPU detected.
> [    0.000000] x86/fpu: Using 'lazy' FPU context switches.
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009dfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000020200000-0x00000000ba96efff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000ba96f000-0x00000000bac6efff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000bac6f000-0x00000000bad6efff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000bad6f000-0x00000000bb3bffff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000bb3c0000-0x00000000bbaccfff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000bbacd000-0x00000000bbad0fff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000bbad1000-0x00000000bbad1fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000bbad2000-0x00000000bbffffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e3ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000feafffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed03000-0x00000000fed03fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed06000-0x00000000fed06fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed09fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1cfff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fedbffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] efi: EFI v2.40 by American Megatrends
> [    0.000000] efi:  ESRT=0xbb7cac98  ACPI=0xbad5d000  ACPI 2.0=0xbad5d000  SMBIOS=0xbb5fbd18 
> [    0.000000] esrt: Reserving ESRT space from 0x00000000bb7cac98 to 0x00000000bb7cad20.
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: Microsoft Corporation Surface 3/Surface 3, BIOS 1.50310.318 03/10/2015
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] e820: last_pfn = 0x140000 max_arch_pfn = 0x400000000
> [    0.000000] MTRR default type: uncachable
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 000000000 mask F80000000 write-back
> [    0.000000]   1 base 080000000 mask FC0000000 write-back
> [    0.000000]   2 base 0BE000000 mask FFE000000 uncachable
> [    0.000000]   3 base 0BD000000 mask FFF000000 uncachable
> [    0.000000]   4 base 0BD000000 mask FFF000000 uncachable
> [    0.000000]   5 base 0BCC00000 mask FFFC00000 uncachable
> [    0.000000]   6 base 0BCA00000 mask FFFE00000 uncachable
> [    0.000000]   7 base 100000000 mask FC0000000 write-back
> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
> [    0.000000] e820: update [mem 0xbca00000-0xffffffff] usable ==> reserved
> [    0.000000] e820: last_pfn = 0xbc000 max_arch_pfn = 0x400000000
> [    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
> [    0.000000] BRK [0x0204e000, 0x0204efff] PGTABLE
> [    0.000000] BRK [0x0204f000, 0x0204ffff] PGTABLE
> [    0.000000] BRK [0x02050000, 0x02050fff] PGTABLE
> [    0.000000] BRK [0x02051000, 0x02051fff] PGTABLE
> [    0.000000] BRK [0x02052000, 0x02052fff] PGTABLE
> [    0.000000] BRK [0x02053000, 0x02053fff] PGTABLE
> [    0.000000] RAMDISK: [mem 0x3ef3c000-0x3fffafff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000BAD5D000 000024 (v02 ALASKA)
> [    0.000000] ACPI: XSDT 0x00000000BAD5D0B0 0000DC (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: FACP 0x00000000BAD6A268 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: DSDT 0x00000000BAD5D218 00D04B (v02 ALASKA A M I    01072009 INTL 20120913)
> [    0.000000] ACPI: APIC 0x00000000BAD6A378 000084 (v03 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: FPDT 0x00000000BAD6A400 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: FIDT 0x00000000BAD6A448 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: TCPA 0x00000000BAD6A4E8 000032 (v02                 00000000      00000000)
> [    0.000000] ACPI: MSDM 0x00000000BAD6A520 000055 (v03 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: MCFG 0x00000000BAD6A578 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
> [    0.000000] ACPI: WDSA 0x00000000BAD6A5B8 00016F (v02 MSHWDS ACTABL   00000003 INTL 20120913)
> [    0.000000] ACPI: UEFI 0x00000000BAD6A728 000042 (v01 ALASKA A M I    00000000      00000000)
> [    0.000000] ACPI: HPET 0x00000000BAD6A770 000038 (v01 ALASKA A M I    01072009 AMI. 00000005)
> [    0.000000] ACPI: SSDT 0x00000000BAD6A7A8 000763 (v01 PmRef  CpuPm    00003000 INTL 20120913)
> [    0.000000] ACPI: SSDT 0x00000000BAD6AF10 000290 (v01 PmRef  Cpu0Tst  00003000 INTL 20120913)
> [    0.000000] ACPI: SSDT 0x00000000BAD6B1A0 00017A (v01 PmRef  ApTst    00003000 INTL 20120913)
> [    0.000000] ACPI: SSDT 0x00000000BAD6B320 000427 (v01 Intel_ Tpm2Tabl 00001000 INTL 20061109)
> [    0.000000] ACPI: TPM2 0x00000000BAD6B748 000034 (v03                 00000000      00000000)
> [    0.000000] ACPI: LPIT 0x00000000BAD6B780 000104 (v01 ALASKA A M I    00000005 MSFT 0100000D)
> [    0.000000] ACPI: OEM0 0x00000000BAD6B888 000084 (v05 INTEL  BATTERY  00000005 INTL 00000000)
> [    0.000000] ACPI: BGRT 0x00000000BAD6B910 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: CSRT 0x00000000BAD6B948 00014C (v00 INTEL  LANFORDC 00000005 MSFT 0100000D)
> [    0.000000] ACPI: SSDT 0x00000000BAD6BA98 001F68 (v01 DptfTb DptfTab  00001000 INTL 20120913)
> [    0.000000] ACPI: SSDT 0x00000000BAD6DA00 000104 (v01 SoCDpf SoCDptf  00001000 INTL 20120913)
> [    0.000000] ACPI: SSDT 0x00000000BAD6DB08 0005C7 (v01 CpuDpf CpuDptf  00001000 INTL 20120913)
> [    0.000000] ACPI: SSDT 0x00000000BAD6E0D0 000058 (v01 LowPM  LowPwrM  00001000 INTL 20120913)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000013fffffff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x13fd71000-0x13fd82fff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000008efff]
> [    0.000000]   node   0: [mem 0x0000000000090000-0x000000000009dfff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
> [    0.000000]   node   0: [mem 0x0000000020200000-0x00000000ba96efff]
> [    0.000000]   node   0: [mem 0x00000000bbacd000-0x00000000bbad0fff]
> [    0.000000]   node   0: [mem 0x00000000bbad2000-0x00000000bbffffff]
> [    0.000000]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
> [    0.000000] On node 0 totalpages: 1027133
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3996 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 11891 pages used for memmap
> [    0.000000]   DMA32 zone: 760993 pages, LIFO batch:31
> [    0.000000]   Normal zone: 4096 pages used for memmap
> [    0.000000]   Normal zone: 262144 pages, LIFO batch:31
> [    0.000000] tboot: non-0 tboot_addr but it is not of type E820_RESERVED
> [    0.000000] Reserving Intel graphics stolen memory at 0xbce00000-0xbedfffff
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-114
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.000000] PM: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xba96f000-0xbac6efff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbac6f000-0xbad6efff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbad6f000-0xbb3bffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbb3c0000-0xbbaccfff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbbad1000-0xbbad1fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbc000000-0xbcdfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbce00000-0xbedfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbee00000-0xdfffffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xe3ffffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xe4000000-0xfe9fffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfea00000-0xfeafffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfeb00000-0xfebfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed00fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed01fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed02000-0xfed02fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed03000-0xfed03fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed04000-0xfed05fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed06000-0xfed06fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed07000-0xfed07fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed08000-0xfed09fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed0a000-0xfed1bfff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1cfff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed1d000-0xfed7ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfedbffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfedc0000-0xfedfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffbfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffffffff]
> [    0.000000] e820: [mem 0xbee00000-0xdfffffff] available for PCI devices
> [    0.000000] Booting paravirtualized kernel on bare hardware
> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.000000] setup_percpu: NR_CPUS:1024 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
> [    0.000000] PERCPU: Embedded 34 pages/cpu @ffff88013f800000 s98712 r8192 d32360 u524288
> [    0.000000] pcpu-alloc: s98712 r8192 d32360 u524288 alloc=1*2097152
> [    0.000000] pcpu-alloc: [0] 0 1 2 3 
> [    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1011061
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.4.0-0.rc0.git7.3.fc24.x86_64 root=UUID=6dadcd59-2499-4ac6-8cd2-fdd2c043b52e ro nomodeset rhgb quiet LANG=en_GB.UTF-8 i2c_hid.debug=1
> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] Memory: 3909748K/4108532K available (7766K kernel code, 1293K rwdata, 3424K rodata, 1528K init, 1544K bss, 198784K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	Build-time adjustment of leaf fanout to 64.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=1024 to nr_cpu_ids=4.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
> [    0.000000] NR_IRQS:65792 nr_irqs:1024 0
> [    0.000000] 	Offload RCU callbacks from all CPUs
> [    0.000000] 	Offload RCU callbacks from CPUs: 0-3.
> [    0.000000] Console: colour dummy device 80x25
> [    0.000000] console [tty0] enabled
> [    0.000000] tsc: Using PIT calibration value
> [    0.000000] tsc: Detected 1599.842 MHz processor
> [    0.000062] Calibrating delay loop (skipped), value calculated using timer frequency.. 3199.68 BogoMIPS (lpj=1599842)
> [    0.000069] pid_max: default: 32768 minimum: 301
> [    0.000088] ACPI: Core revision 20150930
> [    0.032405] ACPI: 9 ACPI AML tables successfully acquired and loaded
> [    0.034044] Security Framework initialized
> [    0.034052] Yama: becoming mindful.
> [    0.034064] SELinux:  Initializing.
> [    0.034090] SELinux:  Starting in permissive mode
> [    0.034888] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> [    0.037265] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> [    0.038309] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.038336] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.038877] Initializing cgroup subsys io
> [    0.038889] Initializing cgroup subsys memory
> [    0.038908] Initializing cgroup subsys devices
> [    0.038917] Initializing cgroup subsys freezer
> [    0.038924] Initializing cgroup subsys net_cls
> [    0.038931] Initializing cgroup subsys perf_event
> [    0.038939] Initializing cgroup subsys net_prio
> [    0.038947] Initializing cgroup subsys hugetlb
> [    0.038961] Initializing cgroup subsys pids
> [    0.039016] CPU: Physical Processor ID: 0
> [    0.039021] CPU: Processor Core ID: 0
> [    0.039030] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.039034] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
> [    0.044447] mce: CPU supports 6 MCE banks
> [    0.044465] CPU0: Thermal monitoring enabled (TM1)
> [    0.044475] process: using mwait in idle threads
> [    0.044482] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
> [    0.044485] Last level dTLB entries: 4KB 256, 2MB 16, 4MB 16, 1GB 0
> [    0.044991] Freeing SMP alternatives memory: 28K (ffffffff81ec3000 - ffffffff81eca000)
> [    0.053986] ftrace: allocating 29314 entries in 115 pages
> [    0.075556] TSC deadline timer enabled
> [    0.075566] smpboot: CPU0: Intel(R) Atom(TM) x7-Z8700  CPU @ 1.60GHz (family: 0x6, model: 0x4c, stepping: 0x3)
> [    0.075621] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont events, full-width counters, Intel PMU driver.
> [    0.075646] ... version:                3
> [    0.075650] ... bit width:              40
> [    0.075652] ... generic registers:      2
> [    0.075655] ... value mask:             000000ffffffffff
> [    0.075658] ... max period:             000000ffffffffff
> [    0.075660] ... fixed-purpose events:   3
> [    0.075663] ... event mask:             0000000700000003
> [    0.077852] x86: Booting SMP configuration:
> [    0.077859] .... node  #0, CPUs:      #1
> [    0.096652] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
> [    0.097062]  #2 #3
> [    0.134526] x86: Booted up 1 node, 4 CPUs
> [    0.134533] smpboot: Total of 4 processors activated (12798.73 BogoMIPS)
> [    0.135920] devtmpfs: initialized
> [    0.144664] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
> [    0.144671] PM: Registering ACPI NVS region [mem 0xbad6f000-0xbb3bffff] (6623232 bytes)
> [    0.145173] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.145446] atomic64_test: passed for x86-64 platform with CX8 and with SSE
> [    0.145454] pinctrl core: initialized pinctrl subsystem
> [    0.145579] RTC time: 11:58:14, date: 11/18/15
> [    0.145996] NET: Registered protocol family 16
> [    0.148387] cpuidle: using governor menu
> [    0.148642] ACPI: bus type PCI registered
> [    0.148648] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.148876] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> [    0.148884] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
> [    0.148892] PCI: MMCONFIG for 0000 [bus00-3f] at [mem 0xe0000000-0xe3ffffff] (base 0xe0000000) (size reduced!)
> [    0.148918] PCI: Using configuration type 1 for base access
> [    0.155555] ACPI: Added _OSI(Module Device)
> [    0.155561] ACPI: Added _OSI(Processor Device)
> [    0.155564] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.155567] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.160611] ACPI : EC: Look up EC in DSDT
> [    0.173213] ACPI Error: Needed [Integer/String/Buffer], found [Device] ffff88013f4a9e10 (20150930/exresop-424)
> [    0.173230] ACPI Exception: AE_AML_OPERAND_TYPE, Could not execute arguments for [KEYS] (Region) (20150930/nsinit-355)
> [    0.177104] \_SB_ _OSC UUID 0811B06E-4A27-44F9-8D60-3CBBC22E7B48
> [    0.177111]  6E B0 11 08 27 4A F9 44 8D 60 3C BB C2 2E 7B 48
> [    0.177897] ACPI: Dynamic OEM Table Load:
> [    0.177919] ACPI: SSDT 0xFFFF880139F02000 00066D (v01 PmRef  Cpu0Ist  00003000 INTL 20120913)
> [    0.179479] ACPI: Dynamic OEM Table Load:
> [    0.179492] ACPI: SSDT 0xFFFF880139F31000 0003A5 (v01 PmRef  Cpu0Cst  00003001 INTL 20120913)
> [    0.181526] ACPI: Dynamic OEM Table Load:
> [    0.181538] ACPI: SSDT 0xFFFF880139F2DE00 00015F (v01 PmRef  ApIst    00003000 INTL 20120913)
> [    0.183049] ACPI: Dynamic OEM Table Load:
> [    0.183060] ACPI: SSDT 0xFFFF880139F6F3C0 00008D (v01 PmRef  ApCst    00003000 INTL 20120913)
> [    0.186385] ACPI: Interpreter enabled
> [    0.186406] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150930/hwxface-580)
> [    0.186421] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150930/hwxface-580)
> [    0.186430] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S3_] (20150930/hwxface-580)
> [    0.186442] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S4_] (20150930/hwxface-580)
> [    0.186461] ACPI: (supports S0 S5)
> [    0.186469] ACPI: Using IOAPIC for interrupt routing
> [    0.186559] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.189570] ACPI: Power Resource [ID3C] (on)
> [    0.191416] ACPI: Power Resource [PRWF] (on)
> [    0.193179] ACPI: Power Resource [USBC] (on)
> [    0.194361] ACPI: Power Resource [WWPR] (off)
> [    0.201365] ACPI Error: No handler for Region [GPOR] (ffff88013f4b35e8) [GeneralPurposeIo] (20150930/evregion-163)
> [    0.201377] ACPI Error: Region GeneralPurposeIo (ID=8) has no handler (20150930/exfldio-297)
> [    0.201387] ACPI Error: Method parse/execution failed [\_SB.PCI0.SPI1.NTRG._STA] (Node ffff88013f4b75a0), AE_NOT_EXIST (20150930/psparse-542)
> [    0.201443] ACPI Error: No handler for Region [GPOR] (ffff88013f4b35e8) [GeneralPurposeIo] (20150930/evregion-163)
> [    0.201451] ACPI Error: Region GeneralPurposeIo (ID=8) has no handler (20150930/exfldio-297)
> [    0.201458] ACPI Error: Method parse/execution failed [\_SB.PCI0.SPI1.NTRG._STA] (Node ffff88013f4b75a0), AE_NOT_EXIST (20150930/psparse-542)
> [    0.201472] ACPI Error: Method execution failed [\_SB.PCI0.SPI1.NTRG._STA] (Node ffff88013f4b75a0), AE_NOT_EXIST (20150930/uteval-103)
> [    0.203593] ACPI: Power Resource [CLK3] (on)
> [    0.210425] ACPI: Power Resource [CLK0] (on)
> [    0.210537] ACPI: Power Resource [CLK1] (on)
> [    0.210779] ACPI: Power Resource [P28X] (off)
> [    0.210883] ACPI: Power Resource [P18X] (off)
> [    0.212235] ACPI Error: No handler for Region [SNOP] (ffff88013f4b6048) [GenericSerialBus] (20150930/evregion-163)
> [    0.212246] ACPI Error: Region GenericSerialBus (ID=9) has no handler (20150930/exfldio-297)
> [    0.212256] ACPI Error: Method parse/execution failed [\_SB.PCI0.I2C4.SAM._SUB] (Node ffff88013f4b5e88), AE_NOT_EXIST (20150930/psparse-542)
> [    0.212271] ACPI Error: Method execution failed [\_SB.PCI0.I2C4.SAM._SUB] (Node ffff88013f4b5e88), AE_NOT_EXIST (20150930/uteval-103)
> [    0.213328] ACPI: Power Resource [TCPR] (off)
> [    0.228087] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.228106] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    0.228114] \_SB_.PCI0 _OSC UUID 33DB4D5B-1FF7-401C-9657-7441C03DD766
> [    0.228119]  5B 4D DB 33 F7 1F 1C 40 96 57 74 41 C0 3D D7 66
> [    0.228308] \_SB_.PCI0 _OSC UUID 33DB4D5B-1FF7-401C-9657-7441C03DD766
> [    0.228312]  5B 4D DB 33 F7 1F 1C 40 96 57 74 41 C0 3D D7 66
> [    0.228499] \_SB_.PCI0 _OSC UUID 33DB4D5B-1FF7-401C-9657-7441C03DD766
> [    0.228503]  5B 4D DB 33 F7 1F 1C 40 96 57 74 41 C0 3D D7 66
> [    0.228690] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> [    0.228729] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
> [    0.229989] PCI host bridge to bus 0000:00
> [    0.229998] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
> [    0.230005] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
> [    0.230010] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
> [    0.230014] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.230021] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.230025] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
> [    0.230030] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
> [    0.230035] pci_bus 0000:00: root bus resource [mem 0x20000000-0x201fffff window]
> [    0.230040] pci_bus 0000:00: root bus resource [mem 0xbce00001-0xbee00000 window]
> [    0.230044] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff window]
> [    0.230050] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.230069] pci 0000:00:00.0: [8086:2280] type 00 class 0x060000
> [    0.230606] pci 0000:00:02.0: [8086:22b0] type 00 class 0x030000
> [    0.230648] pci 0000:00:02.0: reg 0x10: [mem 0xd0000000-0xd0ffffff 64bit]
> [    0.230665] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
> [    0.230677] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
> [    0.230996] pci 0000:00:03.0: [8086:22b8] type 00 class 0x048000
> [    0.231025] pci 0000:00:03.0: reg 0x10: [mem 0xd1000000-0xd13fffff]
> [    0.231366] pci 0000:00:0b.0: [8086:22dc] type 00 class 0x118000
> [    0.231402] pci 0000:00:0b.0: reg 0x10: [mem 0xd1a37000-0xd1a37fff 64bit]
> [    0.231773] pci 0000:00:14.0: [8086:22b5] type 00 class 0x0c0330
> [    0.231820] pci 0000:00:14.0: reg 0x10: [mem 0xd1a00000-0xd1a0ffff 64bit]
> [    0.231912] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.232271] pci 0000:00:1a.0: [8086:2298] type 00 class 0x108000
> [    0.232312] pci 0000:00:1a.0: reg 0x10: [mem 0xd1700000-0xd17fffff]
> [    0.232327] pci 0000:00:1a.0: reg 0x14: [mem 0xd1600000-0xd16fffff]
> [    0.232418] pci 0000:00:1a.0: PME# supported from D0 D3hot
> [    0.232857] pci 0000:00:1c.0: [8086:22c8] type 01 class 0x060400
> [    0.234442] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.235027] pci 0000:00:1f.0: [8086:229c] type 00 class 0x060100
> [    0.236288] pci 0000:01:00.0: [11ab:2b38] type 00 class 0x020000
> [    0.236363] pci 0000:01:00.0: reg 0x10: [mem 0xd1900000-0xd19fffff 64bit pref]
> [    0.236398] pci 0000:01:00.0: reg 0x18: [mem 0xd1800000-0xd18fffff 64bit pref]
> [    0.236649] pci 0000:01:00.0: supports D1 D2
> [    0.236654] pci 0000:01:00.0: PME# supported from D0 D1 D3hot D3cold
> [    0.236795] pci 0000:01:00.0: System wakeup disabled by ACPI
> [    0.239368] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    0.239381] pci 0000:00:1c.0:   bridge window [mem 0xd1800000-0xd19fffff]
> [    0.243454] ACPI Error: No handler for Region [GPOR] (ffff88013f4b35e8) [GeneralPurposeIo] (20150930/evregion-163)
> [    0.243464] ACPI Error: Region GeneralPurposeIo (ID=8) has no handler (20150930/exfldio-297)
> [    0.243476] ACPI Error: Method parse/execution failed [\_SB.PCI0.SPI1.NTRG._STA] (Node ffff88013f4b75a0), AE_NOT_EXIST (20150930/psparse-542)
> [    0.248117] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> [    0.248310] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> [    0.248482] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> [    0.248652] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> [    0.248815] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> [    0.248984] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> [    0.249149] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> [    0.249354] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> [    0.256828] vgaarb: setting as boot device: PCI:0000:00:02.0
> [    0.256837] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
> [    0.256844] vgaarb: loaded
> [    0.256850] vgaarb: bridge control possible 0000:00:02.0
> [    0.257148] SCSI subsystem initialized
> [    0.257277] libata version 3.00 loaded.
> [    0.257381] ACPI: bus type USB registered
> [    0.257440] usbcore: registered new interface driver usbfs
> [    0.257463] usbcore: registered new interface driver hub
> [    0.257520] usbcore: registered new device driver usb
> [    0.258049] PCI: Using ACPI for IRQ routing
> [    0.260789] PCI: pci_cache_line_size set to 64 bytes
> [    0.260974] Expanded resource reserved due to conflict with PCI Bus 0000:00
> [    0.260982] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
> [    0.260987] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
> [    0.260991] e820: reserve RAM buffer [mem 0xba96f000-0xbbffffff]
> [    0.260994] e820: reserve RAM buffer [mem 0xbbad1000-0xbbffffff]
> [    0.261336] NetLabel: Initializing
> [    0.261342] NetLabel:  domain hash size = 128
> [    0.261344] NetLabel:  protocols = UNLABELED CIPSOv4
> [    0.261385] NetLabel:  unlabeled traffic allowed by default
> [    0.261591] clocksource: Switched to clocksource refined-jiffies
> [    0.286665] pnp: PnP ACPI init
> [    0.287070] system 00:00: [io  0x0680-0x069f] has been reserved
> [    0.287077] system 00:00: [io  0x0400-0x047f] has been reserved
> [    0.287082] system 00:00: [io  0x0500-0x05fe] has been reserved
> [    0.287094] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.287342] pnp 00:01: Plug and Play ACPI device, IDs PNP0501 (active)
> [    0.291285] system 00:02: [mem 0xd1a35000-0xd1a35fff] has been reserved
> [    0.291293] system 00:02: [mem 0xd1a33000-0xd1a33fff] has been reserved
> [    0.291299] system 00:02: [mem 0xd1a22000-0xd1a22fff] has been reserved
> [    0.291304] system 00:02: [mem 0xd1a20000-0xd1a20fff] has been reserved
> [    0.291310] system 00:02: [mem 0xd1a1e000-0xd1a1efff] has been reserved
> [    0.291315] system 00:02: [mem 0xd1a1c000-0xd1a1cfff] has been reserved
> [    0.291320] system 00:02: [mem 0xd1a1a000-0xd1a1afff] has been reserved
> [    0.291325] system 00:02: [mem 0xd1a18000-0xd1a18fff] has been reserved
> [    0.291330] system 00:02: [mem 0xd1a31000-0xd1a31fff] has been reserved
> [    0.291335] system 00:02: [mem 0xd1a2f000-0xd1a2ffff] has been reserved
> [    0.291347] system 00:02: [mem 0xd1a2d000-0xd1a2dfff] has been reserved
> [    0.291353] system 00:02: [mem 0xd1a2b000-0xd1a2bfff] has been reserved
> [    0.291358] system 00:02: [mem 0xd1a29000-0xd1a29fff] has been reserved
> [    0.291363] system 00:02: [mem 0xd1a27000-0xd1a27fff] has been reserved
> [    0.291368] system 00:02: [mem 0xd1a25000-0xd1a25fff] has been reserved
> [    0.291373] system 00:02: [mem 0xd1a23000-0xd1a23fff] has been reserved
> [    0.291385] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.291508] system 00:03: [mem 0xe0000000-0xefffffff] could not be reserved
> [    0.291514] system 00:03: [mem 0xfea00000-0xfeafffff] has been reserved
> [    0.291522] system 00:03: [mem 0xfed01000-0xfed01fff] has been reserved
> [    0.291527] system 00:03: [mem 0xfed03000-0xfed03fff] has been reserved
> [    0.291532] system 00:03: [mem 0xfed06000-0xfed06fff] has been reserved
> [    0.291537] system 00:03: [mem 0xfed08000-0xfed09fff] has been reserved
> [    0.291542] system 00:03: [mem 0xfed80000-0xfedbffff] could not be reserved
> [    0.291548] system 00:03: [mem 0xfed1c000-0xfed1cfff] has been reserved
> [    0.291553] system 00:03: [mem 0xfee00000-0xfeefffff] could not be reserved
> [    0.291561] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.291987] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.292851] pnp: PnP ACPI: found 5 devices
> [    0.299404] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
> [    0.299415] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
> [    0.299430] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
> [    0.299436] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
> [    0.299441] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
> [    0.299446] pci 0000:00:1c.0: res[13]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
> [    0.299473] pci 0000:00:1c.0: BAR 15: assigned [mem 0xd1b00000-0xd1cfffff 64bit pref]
> [    0.299481] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
> [    0.299492] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    0.299518] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> [    0.299588] pci 0000:00:1c.0:   bridge window [mem 0xd1800000-0xd19fffff]
> [    0.299636] pci 0000:00:1c.0:   bridge window [mem 0xd1b00000-0xd1cfffff 64bit pref]
> [    0.299727] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
> [    0.299733] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
> [    0.299737] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
> [    0.299742] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
> [    0.299746] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
> [    0.299751] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
> [    0.299755] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff window]
> [    0.299760] pci_bus 0000:00: resource 11 [mem 0x20000000-0x201fffff window]
> [    0.299765] pci_bus 0000:00: resource 12 [mem 0xbce00001-0xbee00000 window]
> [    0.299769] pci_bus 0000:00: resource 13 [mem 0xc0000000-0xdfffffff window]
> [    0.299774] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
> [    0.299778] pci_bus 0000:01: resource 1 [mem 0xd1800000-0xd19fffff]
> [    0.299783] pci_bus 0000:01: resource 2 [mem 0xd1b00000-0xd1cfffff 64bit pref]
> [    0.299909] NET: Registered protocol family 2
> [    0.300385] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
> [    0.300584] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
> [    0.300778] TCP: Hash tables configured (established 32768 bind 32768)
> [    0.300889] UDP hash table entries: 2048 (order: 4, 65536 bytes)
> [    0.300952] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
> [    0.301159] NET: Registered protocol family 1
> [    0.301203] pci 0000:00:02.0: Video device with shadowed ROM
> [    0.301437] PCI: CLS 64 bytes, default 64
> [    0.301612] Unpacking initramfs...
> [    0.944479] Freeing initrd memory: 17148K (ffff88003ef3c000 - ffff88003fffb000)
> [    0.944503] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    0.944511] software IO TLB [mem 0xb6000000-0xba000000] (64MB) mapped at [ffff8800b6000000-ffff8800b9ffffff]
> [    0.946859] futex hash table entries: 1024 (order: 4, 65536 bytes)
> [    0.946947] audit: initializing netlink subsys (disabled)
> [    0.946995] audit: type=2000 audit(1447847894.827:1): initialized
> [    0.947735] Initialise system trusted keyring
> [    0.947961] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    0.952037] zbud: loaded
> [    0.952573] VFS: Disk quotas dquot_6.6.0
> [    0.952695] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.953873] Key type big_key registered
> [    0.953884] SELinux:  Registering netfilter hooks
> [    0.968077] NET: Registered protocol family 38
> [    0.968107] Key type asymmetric registered
> [    0.968117] Asymmetric key parser 'x509' registered
> [    0.968297] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
> [    0.968404] io scheduler noop registered
> [    0.968414] io scheduler deadline registered
> [    0.968524] io scheduler cfq registered (default)
> [    0.970925] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
> [    0.970934] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
> [    0.970983] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
> [    0.971002] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    0.971097] pciehp 0000:00:1c.0:pcie04: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
> [    0.971259] pciehp 0000:00:1c.0:pcie04: service driver pciehp loaded
> [    0.971277] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> [    0.971374] efifb: probing for efifb
> [    0.971422] efifb: framebuffer at 0xc0000000, mapped to 0xffffc90000800000, using 1876k, total 1875k
> [    0.971426] efifb: mode is 800x600x32, linelength=3200, pages=1
> [    0.971428] efifb: scrolling: redraw
> [    0.971432] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    0.971761] Console: switching to colour frame buffer device 100x37
> [    0.975486] fb0: EFI VGA frame buffer device
> [    0.975534] intel_idle: MWAIT substates: 0x33000020
> [    0.975538] intel_idle: v0.4 model 0x4C
> [    0.975541] intel_idle: lapic_timer_reliable_states 0xffffffff
> [    0.976263] ACPI: AC Adapter [ADP1] (off-line)
> [    0.976468] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [    0.976476] ACPI: Power Button [PWRB]
> [    0.976577] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
> [    0.976584] ACPI: Sleep Button [SLPB]
> [    0.976700] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
> [    0.976748] ACPI: Lid Switch [LID]
> [    0.981348] GHES: HEST is not enabled!
> [    0.981617] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    1.002137] 00:01: ttyS0 at I/O 0x3f8 (irq = 224, base_baud = 115200) is a 16550A
> [    1.006736] 8086228A:00: ttyS4 at MMIO 0xd1a21000 (irq = 4, base_baud = 2764800) is a 16550A
> [    1.007147] 8086228A:01: ttyS5 at MMIO 0xd1a1f000 (irq = 5, base_baud = 2764800) is a 16550A
> [    1.007950] hpet: number irqs doesn't agree with number of timers
> [    1.008075] Non-volatile memory driver v1.3
> [    1.008172] Linux agpgart interface v0.103
> [    1.009584] libphy: Fixed MDIO Bus: probed
> [    1.009745] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.009760] ehci-pci: EHCI PCI platform driver
> [    1.009799] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    1.009814] ohci-pci: OHCI PCI platform driver
> [    1.009841] uhci_hcd: USB Universal Host Controller Interface driver
> [    1.010223] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    1.010374] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> [    1.010631] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00109810
> [    1.010649] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
> [    1.011036] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    1.011045] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.011050] usb usb1: Product: xHCI Host Controller
> [    1.011054] usb usb1: Manufacturer: Linux 4.4.0-0.rc0.git7.3.fc24.x86_64 xhci-hcd
> [    1.011058] usb usb1: SerialNumber: 0000:00:14.0
> [    1.011459] hub 1-0:1.0: USB hub found
> [    1.011493] hub 1-0:1.0: 7 ports detected
> [    1.012775] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    1.012917] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> [    1.013027] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
> [    1.013033] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.013037] usb usb2: Product: xHCI Host Controller
> [    1.013041] usb usb2: Manufacturer: Linux 4.4.0-0.rc0.git7.3.fc24.x86_64 xhci-hcd
> [    1.013045] usb usb2: SerialNumber: 0000:00:14.0
> [    1.013359] hub 2-0:1.0: USB hub found
> [    1.013404] hub 2-0:1.0: 6 ports detected
> [    1.013760] usb: failed to peer usb2-port2 and usb1-port1 by location (usb2-port2:none) (usb1-port1:usb2-port1)
> [    1.013765] usb usb2-port2: failed to peer to usb1-port1 (-16)
> [    1.013768] usb: port power management may be unreliable
> [    1.013910] usb: failed to peer usb2-port3 and usb1-port1 by location (usb2-port3:none) (usb1-port1:usb2-port1)
> [    1.013915] usb usb2-port3: failed to peer to usb1-port1 (-16)
> [    1.014064] usb: failed to peer usb2-port4 and usb1-port1 by location (usb2-port4:none) (usb1-port1:usb2-port1)
> [    1.014069] usb usb2-port4: failed to peer to usb1-port1 (-16)
> [    1.014205] usb: failed to peer usb2-port5 and usb1-port1 by location (usb2-port5:none) (usb1-port1:usb2-port1)
> [    1.014211] usb usb2-port5: failed to peer to usb1-port1 (-16)
> [    1.014350] usb: failed to peer usb2-port6 and usb1-port1 by location (usb2-port6:none) (usb1-port1:usb2-port1)
> [    1.014355] usb usb2-port6: failed to peer to usb1-port1 (-16)
> [    1.014752] usbcore: registered new interface driver usbserial
> [    1.014778] usbcore: registered new interface driver usbserial_generic
> [    1.014800] usbserial: USB Serial support registered for generic
> [    1.014885] i8042: PNP: No PS/2 controller found. Probing ports directly.
> [    2.095995] i8042: No controller found
> [    2.096269] mousedev: PS/2 mouse device common for all mice
> [    2.096941] ACPI Warning: Could not enable fixed event - RealTimeClock (4) (20150930/evxface-654)
> [    2.097289] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
> [    2.097360] rtc_cmos 00:04: alarms up to one day, 242 bytes nvram
> [    2.097543] device-mapper: uevent: version 1.0.3
> [    2.097771] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel@redhat.com
> [    2.097949] Intel P-state driver initializing.
> [    2.099586] hidraw: raw HID events driver (C) Jiri Kosina
> [    2.099976] usbcore: registered new interface driver usbhid
> [    2.099990] usbhid: USB HID core driver
> [    2.100680] drop_monitor: Initializing network drop monitor service
> [    2.101200] ip_tables: (C) 2000-2006 Netfilter Core Team
> [    2.101413] Initializing XFRM netlink socket
> [    2.102692] NET: Registered protocol family 10
> [    2.104220] mip6: Mobile IPv6
> [    2.104257] NET: Registered protocol family 17
> [    2.105908] SSE version of gcm_enc/dec engaged.
> [    2.125039] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x170f8fa7afd, max_idle_ns: 440795249780 ns
> [    2.140046] clocksource: Switched to clocksource tsc
> [    2.170094] registered taskstats version 1
> [    2.170134] Loading compiled-in X.509 certificates
> [    2.172765] Loaded X.509 cert 'Fedora kernel signing key: 7f87fbbd4c585d8712955db375636155dac694cb'
> [    2.172843] zswap: loaded using pool lzo/zbud
> [    2.174130]   Magic number: 7:990:984
> [    2.174471] rtc_cmos 00:04: setting system clock to 2015-11-18 11:58:16 UTC (1447847896)
> [    2.175119] PM: Hibernation image not present or could not be loaded.
> [    2.179004] Freeing unused kernel memory: 1528K (ffffffff81d45000 - ffffffff81ec3000)
> [    2.179012] Write protecting the kernel read-only data: 12288k
> [    2.180231] Freeing unused kernel memory: 412K (ffff880001799000 - ffff880001800000)
> [    2.184021] Freeing unused kernel memory: 672K (ffff880001b58000 - ffff880001c00000)
> [    2.184065] ------------[ cut here ]------------
> [    2.184076] WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:225 note_page+0x5e1/0x780()
> [    2.184081] x86/mm: Found insecure W+X mapping at address ffff880001c00000/0xffff880001c00000
> [    2.184084] Modules linked in:
> [    2.184091] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.0-0.rc0.git7.3.fc24.x86_64 #1
> [    2.184094] Hardware name: Microsoft Corporation Surface 3/Surface 3, BIOS 1.50310.318 03/10/2015
> [    2.184097]  0000000000000000 000000006ef97ae6 ffff880139c27d48 ffffffff813aea8f
> [    2.184102]  ffff880139c27d90 ffff880139c27d80 ffffffff810a1a22 ffff880139c27e90
> [    2.184107]  0000000000000163 0000000000000004 0000000000000000 0000000000000000
> [    2.184111] Call Trace:
> [    2.184121]  [<ffffffff813aea8f>] dump_stack+0x44/0x55
> [    2.184127]  [<ffffffff810a1a22>] warn_slowpath_common+0x82/0xc0
> [    2.184131]  [<ffffffff810a1abc>] warn_slowpath_fmt+0x5c/0x80
> [    2.184135]  [<ffffffff8106f6b1>] note_page+0x5e1/0x780
> [    2.184140]  [<ffffffff8106fb5c>] ptdump_walk_pgd_level_core+0x30c/0x440
> [    2.184145]  [<ffffffff8106fd37>] ptdump_walk_pgd_level_checkwx+0x17/0x20
> [    2.184149]  [<ffffffff81065a64>] mark_rodata_ro+0xf4/0x100
> [    2.184154]  [<ffffffff81785360>] ? rest_init+0x80/0x80
> [    2.184158]  [<ffffffff8178537d>] kernel_init+0x1d/0xe0
> [    2.184163]  [<ffffffff8179134f>] ret_from_fork+0x3f/0x70
> [    2.184167]  [<ffffffff81785360>] ? rest_init+0x80/0x80
> [    2.184170] ---[ end trace d16986b6dd8293fa ]---
> [    2.200571] x86/mm: Checked W+X mappings: FAILED, 56407 W+X pages found.
> [    2.222095] random: systemd urandom read with 11 bits of entropy available
> [    2.225608] systemd[1]: systemd 222 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
> [    2.225972] systemd[1]: Detected architecture x86-64.
> [    2.225979] systemd[1]: Running in initial RAM disk.
> [    2.226027] systemd[1]: Set hostname to <surface>.
> [    2.327387] systemd[1]: Created slice -.slice.
> [    2.327414] systemd[1]: Starting -.slice.
> [    2.327519] systemd[1]: Listening on Journal Socket.
> [    2.327538] systemd[1]: Starting Journal Socket.
> [    2.327608] systemd[1]: Listening on udev Control Socket.
> [    2.327626] systemd[1]: Starting udev Control Socket.
> [    2.327801] systemd[1]: Listening on Journal Audit Socket.
> [    2.327819] systemd[1]: Starting Journal Audit Socket.
> [    2.327966] systemd[1]: Created slice System Slice.
> [    2.327985] systemd[1]: Starting System Slice.
> [    2.328059] systemd[1]: Started dracut ask for additional cmdline parameters.
> [    2.337638] systemd[1]: Starting Setup Virtual Console...
> [    2.338093] systemd[1]: Started Load Kernel Modules.
> [    2.339664] systemd[1]: Starting Create list of required static device nodes for the current kernel...
> [    2.339714] systemd[1]: Reached target Swap.
> [    2.339747] systemd[1]: Starting Swap.
> [    2.339865] systemd[1]: Listening on Journal Socket (/dev/log).
> [    2.339884] systemd[1]: Starting Journal Socket (/dev/log).
> [    2.341105] systemd[1]: Starting Journal Service...
> [    2.344032] systemd[1]: Starting dracut cmdline hook...
> [    2.344154] systemd[1]: Listening on udev Kernel Socket.
> [    2.344182] systemd[1]: Starting udev Kernel Socket.
> [    2.344216] systemd[1]: Reached target Sockets.
> [    2.344235] systemd[1]: Starting Sockets.
> [    2.344271] systemd[1]: Reached target Slices.
> [    2.344287] systemd[1]: Starting Slices.
> [    2.344333] systemd[1]: Reached target Timers.
> [    2.344349] systemd[1]: Starting Timers.
> [    2.345681] systemd[1]: Starting Apply Kernel Variables...
> [    2.345729] systemd[1]: Reached target Local File Systems.
> [    2.345763] systemd[1]: Starting Local File Systems.
> [    2.346977] systemd[1]: Started Create list of required static device nodes for the current kernel.
> [    2.349886] audit: type=1130 audit(1447847896.674:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.350622] systemd[1]: Started Apply Kernel Variables.
> [    2.350705] audit: type=1130 audit(1447847896.675:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.358450] systemd[1]: Starting Create Static Device Nodes in /dev...
> [    2.363937] usb 1-2: new high-speed USB device number 2 using xhci_hcd
> [    2.367479] systemd[1]: Started Create Static Device Nodes in /dev.
> [    2.367595] audit: type=1130 audit(1447847896.692:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.385859] systemd[1]: Started Journal Service.
> [    2.385980] audit: type=1130 audit(1447847896.710:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.495943] audit: type=1130 audit(1447847896.820:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.528152] usb 1-2: New USB device found, idVendor=0424, idProduct=2137
> [    2.528159] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    2.528162] usb 1-2: Product: USB2137
> [    2.528165] usb 1-2: Manufacturer: SMSC
> [    2.528640] hub 1-2:1.0: USB hub found
> [    2.528677] hub 1-2:1.0: 7 ports detected
> [    2.547519] audit: type=1130 audit(1447847896.872:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.554259] audit: type=1130 audit(1447847896.878:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.573608] audit: type=1130 audit(1447847896.898:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.608487] audit: type=1130 audit(1447847896.933:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.683326] usb 1-3: new full-speed USB device number 3 using xhci_hcd
> [    2.777825] sdhci: Secure Digital Host Controller Interface driver
> [    2.777832] sdhci: Copyright(c) Pierre Ossman
> [    2.782160] sdhci-acpi 80860F14:00: No vmmc regulator found
> [    2.782168] sdhci-acpi 80860F14:00: No vqmmc regulator found
> [    2.786635] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
> [    2.789488] sdhci-acpi 80860F14:01: No vmmc regulator found
> [    2.789495] sdhci-acpi 80860F14:01: No vqmmc regulator found
> [    2.792274] FUJITSU Extended Socket Network Device Driver - version 1.0 - Copyright (c) 2015 FUJITSU LIMITED
> [    2.795613] mmc1: SDHCI controller on ACPI [80860F14:01] using ADMA
> [    2.855630] usb 1-3: New USB device found, idVendor=045e, idProduct=07de
> [    2.855638] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    2.855641] usb 1-3: Product: Surface Type Cover
> [    2.855644] usb 1-3: Manufacturer: Microsoft
> [    2.869558] [drm] Initialized drm 1.1.0 20060810
> [    2.896040] mmc0: MAN_BKOPS_EN bit is not set
> [    2.904984] mmc0: new HS200 MMC card at address 0001
> [    2.905235] input: Microsoft Surface Type Cover as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DE.0001/input/input3
> [    2.913347] mmcblk0: mmc0:0001 MDGAGC 116 GiB 
> [    2.914542] mmcblk0boot0: mmc0:0001 MDGAGC partition 1 4.00 MiB
> [    2.914804] mmcblk0boot1: mmc0:0001 MDGAGC partition 2 4.00 MiB
> [    2.914958] mmcblk0rpmb: mmc0:0001 MDGAGC partition 3 4.00 MiB
> [    2.917425]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
> [    2.926327] usb 1-2.4: new full-speed USB device number 4 using xhci_hcd
> [    2.957394] microsoft 0003:045E:07DE.0001: input,hiddev0,hidraw0: USB HID v1.11 Keyboard [Microsoft Surface Type Cover] on usb-0000:00:14.0-3/input0
> [    3.013134] usb 1-2.4: New USB device found, idVendor=046d, idProduct=c52b
> [    3.013142] usb 1-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    3.013145] usb 1-2.4: Product: USB Receiver
> [    3.013148] usb 1-2.4: Manufacturer: Logitech
> [    3.091443] usb 1-2.6: new full-speed USB device number 5 using xhci_hcd
> [    3.179814] usb 1-2.6: New USB device found, idVendor=0596, idProduct=0524
> [    3.179828] usb 1-2.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    3.179842] usb 1-2.6: Product: 3M MicroTouch USB controller
> [    3.179847] usb 1-2.6: Manufacturer: 3M
> [    3.259174] usb 1-2.7: new high-speed USB device number 6 using xhci_hcd
> [    3.443133] usb 1-2.7: New USB device found, idVendor=0bda, idProduct=570a
> [    3.443149] usb 1-2.7: New USB device strings: Mfr=3, Product=1, SerialNumber=2
> [    3.443158] usb 1-2.7: Product: DELL S2340T Webcam
> [    3.443167] usb 1-2.7: Manufacturer: 56.18006.48133B10J
> [    3.443173] usb 1-2.7: SerialNumber: 201209030001
> [    3.636115] usb 1-2.1: new high-speed USB device number 7 using xhci_hcd
> [    3.724811] usb 1-2.1: New USB device found, idVendor=0424, idProduct=2134
> [    3.724824] usb 1-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    3.724837] usb 1-2.1: Product: USB2134
> [    3.724842] usb 1-2.1: Manufacturer: SMSC
> [    3.726292] hub 1-2.1:1.0: USB hub found
> [    3.726405] hub 1-2.1:1.0: 4 ports detected
> [    3.832992] EXT4-fs (mmcblk0p6): mounted filesystem with ordered data mode. Opts: (null)
> [    4.292021] systemd-journald[168]: Received SIGTERM from PID 1 (systemd).
> [    4.438886] SELinux: 32768 avtab hash slots, 103234 rules.
> [    4.471071] SELinux: 32768 avtab hash slots, 103234 rules.
> [    4.549894] SELinux:  8 users, 14 roles, 4897 types, 305 bools, 1 sens, 1024 cats
> [    4.549902] SELinux:  92 classes, 103234 rules
> [    4.556286] SELinux:  Completing initialization.
> [    4.556313] SELinux:  Setting up existing superblocks.
> [    4.583686] systemd[1]: Successfully loaded SELinux policy in 188.208ms.
> [    4.607101] systemd[1]: RTC configured in localtime, applying delta of 60 minutes to system time.
> [    4.699847] systemd[1]: Relabelled /dev and /run in 82.889ms.
> [    5.051189] EXT4-fs (mmcblk0p6): re-mounted. Opts: (null)
> [    5.114132] RPC: Registered named UNIX socket transport module.
> [    5.114138] RPC: Registered udp transport module.
> [    5.114140] RPC: Registered tcp transport module.
> [    5.114142] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    5.172967] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> [    5.193260] systemd-journald[502]: Received request to flush runtime journal from PID 1
> [    5.723997] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
> [    5.724552] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels
> [    5.728092] i2c_hid i2c-MSHW0102:00: Fetching the HID descriptor
> [    5.728101] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=01 00
> [    5.731335] i2c_hid i2c-MSHW0102:00: HID Descriptor: 1e 00 00 01 8e 06 02 00 03 00 3f 00 04 00 3f 00 05 00 06 00 5e 04 bd 07 03 00 00 00 00 00
> [    5.733249] i2c_hid i2c-MSHW0102:00: entering i2c_hid_parse
> [    5.733256] i2c_hid i2c-MSHW0102:00: i2c_hid_hwreset
> [    5.733260] i2c_hid i2c-MSHW0102:00: i2c_hid_set_power
> [    5.733264] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 00 08
> [    5.734331] i2c_hid i2c-MSHW0102:00: input: 34 00 23 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    5.738335] i2c_hid i2c-MSHW0102:00: input: 34 00 11 22 ab 4e 91 01 00 00 03 dc 04 53 65 6c 66 74 65 73 74 20 30 78 30 30 30 30 30 30 30 34 00 b7 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    5.741327] i2c_hid i2c-MSHW0102:00: input: 34 00 11 1e 11 2d 07 03 02 00 00 00 00 00 00 00 57 a4 00 00 ab 4e 91 01 00 00 03 dc 04 53 65 6c 66 74 65 73 74 20 30 78 30 30 30 30 30 30 30 34 00 b7 00 00
> [    5.742345] i2c_hid i2c-MSHW0102:00: resetting...
> [    5.742360] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 00 01
> [    5.745330] i2c_hid i2c-MSHW0102:00: input: 34 00 11 22 ab 4f 91 01 00 00 03 dc 04 53 65 6c 66 74 65 73 74 20 30 78 30 30 30 30 30 30 30 34 00 23 00 00 80 00 00 00 04 f2 ff 1f 00 00 00 00 74 f9 ff 1f
> [    5.749330] i2c_hid i2c-MSHW0102:00: input: 34 00 11 1e 11 2d 07 03 18 00 00 00 0c 20 01 00 64 3e 00 20 fd 01 00 00 f1 ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 41 5b 00 00 4f c5 00 00
> [    5.750257] wmi: Mapper loaded
> [    5.753324] i2c_hid i2c-MSHW0102:00: input: 34 00 11 22 ab 50 91 01 00 00 03 dc 04 53 65 6c 66 74 65 73 74 20 30 78 30 30 30 30 30 30 30 34 00 4c 00 00 00 01 00 00 04 f2 ff 1f 00 00 00 00 74 f9 ff 1f
> [    5.756320] i2c_hid i2c-MSHW0102:00: input: 34 00 11 1e 11 2d 07 03 02 00 00 00 00 00 00 00 57 a4 00 00 ab 50 91 01 00 00 03 dc 04 53 65 6c 66 74 65 73 74 20 30 78 30 30 30 30 30 30 30 34 00 4c 00 00
> [    5.759322] i2c_hid i2c-MSHW0102:00: input: 34 00 11 22 ab 51 91 01 00 00 03 dc 04 53 65 6c 66 74 65 73 74 20 30 78 30 30 30 30 30 30 30 34 00 d8 ad de 34 90 04 40 01 00 00 00 a0 f1 ff 1f fb cf 00 00
> [    5.763327] i2c_hid i2c-MSHW0102:00: input: 34 00 11 1e 11 2d 07 03 bf 89 00 00 cc f9 ff 1f ed 89 00 00 24 3f 00 20 f1 ff ff ff 00 00 00 00 1e 00 00 00 3d a5 00 00 ff ff 00 00 cc f9 ff 1f 13 00 00 00
> [    5.764944] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: waiting...
> [    5.768348] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: finished.
> [    5.768358] i2c_hid i2c-MSHW0102:00: asking HID report descriptor
> [    5.768363] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=02 00
> [    5.818333] i2c_hid i2c-MSHW0102:00: Report Descriptor: 05 20 09 01 a1 01 85 01 05 20 09 73 a1 00 0a 09 03 15 00 25 02 75 08 95 01 a1 02 0a 30 08 0a 31 08 0a 32 08 b1 00 c0 0a 0e 03 15 00 27 ff ff ff ff 75 20 95 01 55 00 b1 02 0a 52 14 15 00 26 ff
> [    5.819766] i2c_hid i2c-MSHW0102:00: i2c_hid_set_power
> [    5.819774] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 01 08
> [    5.824458] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    5.845074] random: nonblocking pool is initialized
> [    5.880807] i2c i2c-6: Failed to register i2c client MSHW0011:00 at 0x6e (-16)
> [    5.880816] i2c i2c-6: failed to add I2C device MSHW0011:00 from ACPI
> [    5.885569] proc_thermal 0000:00:0b.0: enabling device (0000 -> 0002)
> [    5.890627] intel_sst_acpi 808622A8:00: No matching machine driver found
> [    5.897986] media: Linux media interface: v0.10
> [    5.900205] logitech-djreceiver 0003:046D:C52B.0004: hiddev0,hidraw1: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-2.4/input2
> [    5.953621] input: 3M 3M MicroTouch USB controller as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.6/1-2.6:1.0/0003:0596:0524.0005/input/input4
> [    5.957627] hid-multitouch 0003:0596:0524.0005: input,hiddev0,hidraw2: USB HID v1.10 Pointer [3M 3M MicroTouch USB controller] on usb-0000:00:14.0-2.6/input0
> [    5.963400] rt5640 i2c-10EC5640:00: Device with ID register 0x6308 is not rt5640/39
> [    5.963731] mwifiex_pcie 0000:01:00.0: enabling device (0000 -> 0002)
> [    5.963973] mwifiex: rx work enabled, cpus 4
> [    5.967068] Linux video capture interface: v2.00
> [    6.156475] audit_printk_skb: 162 callbacks suppressed
> [    6.156482] audit: type=1130 audit(1447844300.481:65): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-fsck@dev-disk-by\x2duuid-c43308f2\x2dad28\x2d4c0e\x2d93d5\x2d17cb6a415c7a comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.178250] audit: type=1130 audit(1447844300.502:66): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-fsck@dev-disk-by\x2duuid-5C9B\x2dF942 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.181591] EXT4-fs (mmcblk0p5): mounted filesystem with ordered data mode. Opts: (null)
> [    6.189085] EXT4-fs (mmcblk0p7): mounted filesystem with ordered data mode. Opts: (null)
> [    6.302207] usbcore: registered new interface driver snd-usb-audio
> [    6.302496] uvcvideo: Found UVC 1.00 device DELL S2340T Webcam (0bda:570a)
> [    6.312186] input: DELL S2340T Webcam as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.7/1-2.7:1.0/input/input5
> [    6.312595] usbcore: registered new interface driver uvcvideo
> [    6.312599] USB Video Class driver (1.1.1)
> [    6.368462] i2c_hid i2c-MSHW0102:00: i2c_hid_set_power
> [    6.368470] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 00 08
> [    6.369920] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.369926] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 31 02 06 00
> [    6.370828] i2c_hid i2c-MSHW0102:00: report (len=14): 0e 00 01 01 10 00 00 00 64 00 02 06 02 10
> [    6.370836] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.370840] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 32 02 06 00
> [    6.371553] i2c_hid i2c-MSHW0102:00: report (len=14): 0e 00 02 01 10 00 00 00 64 00 02 06 02 10
> [    6.371560] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.371564] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 33 02 06 00
> [    6.372818] i2c_hid i2c-MSHW0102:00: report (len=30): 1e 00 03 01 64 00 00 00 e8 03 02 06 02 64 28 00 0a 00 64 00 0b 00 64 00 40 1f 0f 27 41 1f
> [    6.372825] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.372828] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 34 02 06 00
> [    6.373572] i2c_hid i2c-MSHW0102:00: report (len=14): 0e 00 04 01 10 00 00 00 e8 03 02 06 02 10
> [    6.373577] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.373580] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 3f 02 20 06 00
> [    6.377269] i2c_hid i2c-MSHW0102:00: report (len=63): 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    6.377275] i2c_hid i2c-MSHW0102:00: error in i2c_hid_init_report size:63 / ret_size:3
> [    6.377279] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.377282] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 3f 02 21 06 00
> [    6.380952] i2c_hid i2c-MSHW0102:00: report (len=63): 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    6.380956] i2c_hid i2c-MSHW0102:00: error in i2c_hid_init_report size:63 / ret_size:3
> [    6.380960] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.380962] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 3f 02 22 06 00
> [    6.381876] i2c_hid i2c-MSHW0102:00: report (len=19): 13 00 22 11 2d 07 03 00 00 00 00 00 00 00 00 00 00 00 00
> [    6.381885] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.381889] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 3f 02 23 06 00
> [    6.385306] i2c_hid i2c-MSHW0102:00: report (len=19): 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    6.385311] i2c_hid i2c-MSHW0102:00: error in i2c_hid_init_report size:19 / ret_size:3
> [    6.385314] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.385317] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 3f 02 24 06 00
> [    6.387675] i2c_hid i2c-MSHW0102:00: report (len=19): 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    6.387679] i2c_hid i2c-MSHW0102:00: error in i2c_hid_init_report size:19 / ret_size:3
> [    6.387683] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.387686] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 3f 02 25 06 00
> [    6.389936] i2c_hid i2c-MSHW0102:00: report (len=19): 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    6.389941] i2c_hid i2c-MSHW0102:00: error in i2c_hid_init_report size:19 / ret_size:3
> [    6.389944] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.389947] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 3f 02 26 06 00
> [    6.392303] i2c_hid i2c-MSHW0102:00: report (len=19): 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    6.392307] i2c_hid i2c-MSHW0102:00: error in i2c_hid_init_report size:19 / ret_size:3
> [    6.392311] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.392314] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 3f 02 27 06 00
> [    6.394569] i2c_hid i2c-MSHW0102:00: report (len=19): 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    6.394574] i2c_hid i2c-MSHW0102:00: error in i2c_hid_init_report size:19 / ret_size:3
> [    6.394577] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.394580] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 3f 02 28 06 00
> [    6.403249] i2c_hid i2c-MSHW0102:00: report (len=19): 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    6.403254] i2c_hid i2c-MSHW0102:00: error in i2c_hid_init_report size:19 / ret_size:3
> [    6.403257] i2c_hid i2c-MSHW0102:00: i2c_hid_get_report
> [    6.403260] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 3f 02 29 06 00
> [    6.406306] i2c_hid i2c-MSHW0102:00: report (len=19): 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    6.406311] i2c_hid i2c-MSHW0102:00: error in i2c_hid_init_report size:19 / ret_size:3
> [    6.406737] i2c_hid i2c-MSHW0102:00: i2c_hid_set_power
> [    6.406741] i2c_hid i2c-MSHW0102:00: __i2c_hid_command: cmd=05 00 01 08
> [    6.415968] intel_rapl: Found RAPL domain package
> [    6.415975] intel_rapl: Found RAPL domain core
> [    6.457446] iTCO_vendor_support: vendor-support=0
> [    6.460919] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> [    6.461059] iTCO_wdt: Found a Braswell SoC TCO device (Version=3, TCOBASE=0x0460)
> [    6.468492] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
> [    6.501451] cfg80211: World regulatory domain updated:
> [    6.501460] cfg80211:  DFS Master region: unset
> [    6.501462] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
> [    6.501467] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
> [    6.501470] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
> [    6.501472] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (N/A, 2000 mBm), (N/A)
> [    6.501475] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
> [    6.501479] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
> [    6.501481] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz), (N/A, 2000 mBm), (0 s)
> [    6.501484] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 2000 mBm), (N/A)
> [    6.501486] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz), (N/A, 0 mBm), (N/A)
> [    6.501782] input: Logitech K750 as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.4/1-2.4:1.2/0003:046D:C52B.0004/0003:046D:4002.0007/input/input6
> [    6.508473] logitech-hidpp-device 0003:046D:4002.0007: input,hidraw3: USB HID v1.11 Keyboard [Logitech K750] on usb-0000:00:14.0-2.4:1
> [    6.513876] logitech-hidpp-device 0003:046D:4101.0008: hidraw4: USB HID v1.11 Keyboard [Logitech T650] on usb-0000:00:14.0-2.4:2
> [    6.632786] usb 1-2: USB disconnect, device number 2
> [    6.632794] usb 1-2.1: USB disconnect, device number 7
> [    6.633427] usb 1-2.4: USB disconnect, device number 4
> [    6.973656] mwifiex_pcie 0000:01:00.0: info: FW download over, size 759128 bytes
> [    7.019691] usb 1-2.6: USB disconnect, device number 5
> [    7.029537] audit: type=1130 audit(1447844301.354:67): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-udev-settle comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    7.044750] usb 1-2.7: USB disconnect, device number 6
> [    7.098269] audit: type=1130 audit(1447844301.422:68): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    7.098323] audit: type=1131 audit(1447844301.422:69): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    7.130347] audit: type=1130 audit(1447844301.454:70): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    7.131370] audit: type=1130 audit(1447844301.456:71): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    7.138844] audit: type=1130 audit(1447844301.463:72): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    7.138885] audit: type=1131 audit(1447844301.463:73): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    7.165370] audit: type=1130 audit(1447844301.490:74): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=fedora-import-state comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    7.714927] usb 1-4: new high-speed USB device number 8 using xhci_hcd
> [    7.879600] usb 1-4: New USB device found, idVendor=1286, idProduct=204c
> [    7.879607] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    7.879611] usb 1-4: Product: Bluetooth and Wireless LAN Composite Device
> [    7.879613] usb 1-4: Manufacturer: Marvell
> [    7.879616] usb 1-4: SerialNumber: 0000000000000000
> [    7.986455] mwifiex_pcie 0000:01:00.0: WLAN FW is active
> [    8.003453] Bluetooth: Core ver 2.21
> [    8.004139] NET: Registered protocol family 31
> [    8.004144] Bluetooth: HCI device and connection manager initialized
> [    8.004153] Bluetooth: HCI socket layer initialized
> [    8.004159] Bluetooth: L2CAP socket layer initialized
> [    8.004180] Bluetooth: SCO socket layer initialized
> [    8.029932] usbcore: registered new interface driver btusb
> [    8.086243] mwifiex_pcie 0000:01:00.0 mlan0: set_features() failed (-1); wanted 0x0000000000004000, left 0x0000000000004800
> [    8.094175] mwifiex_pcie 0000:01:00.0: info: MWIFIEX VERSION: mwifiex 1.0 (15.68.4.p112) 
> [    8.094183] mwifiex_pcie 0000:01:00.0: driver_version = mwifiex 1.0 (15.68.4.p112) 
> [    8.104765] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    8.104771] Bluetooth: BNEP filters: protocol multicast
> [    8.104781] Bluetooth: BNEP socket layer initialized
> [    8.115399] mwifiex_pcie 0000:01:00.0 wlp1s0: renamed from mlan0
> [    8.166481] cfg80211: Regulatory domain changed to country: FR
> [    8.166490] cfg80211:  DFS Master region: ETSI
> [    8.166493] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
> [    8.166497] cfg80211:   (2402000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
> [    8.166500] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
> [    8.166503] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
> [    8.166506] cfg80211:   (5490000 KHz - 5710000 KHz @ 160000 KHz), (N/A, 2700 mBm), (0 s)
> [    8.166509] cfg80211:   (57000000 KHz - 66000000 KHz @ 2160000 KHz), (N/A, 4000 mBm), (N/A)
> [    8.373062] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
> [    8.454501] ip6_tables: (C) 2000-2006 Netfilter Core Team
> [    8.602893] Ebtables v2.0 registered
> [    8.645175] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
> [    9.553171] IPv6: ADDRCONF(NETDEV_UP): wlp1s0: link is not ready
> [    9.555997] IPv6: ADDRCONF(NETDEV_UP): wlp1s0: link is not ready
> [    9.729716] IPv6: ADDRCONF(NETDEV_UP): wlp1s0: link is not ready
> [   11.112797] mwifiex_pcie 0000:01:00.0: info: trying to associate to 'idoru' bssid f4:ca:e5:c2:74:6c
> [   11.151645] mwifiex_pcie 0000:01:00.0: info: associated to bssid f4:ca:e5:c2:74:6c successfully
> [   11.151703] IPv6: ADDRCONF(NETDEV_CHANGE): wlp1s0: link becomes ready
> [   12.448526] fuse init (API version 7.23)
> [   12.615691] tun: Universal TUN/TAP device driver, 1.6
> [   12.615696] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> [   12.617144] virbr0-nic: set_features() failed (-1); wanted 0x00000080000048c1, left 0x00000080001b48c9
> [   12.664950] virbr0-nic: set_features() failed (-1); wanted 0x00000080000048c1, left 0x00000080001b48c9
> [   12.664974] device virbr0-nic entered promiscuous mode
> [   12.665019] virbr0: set_features() failed (-1); wanted 0x000000801fdb78c9, left 0x000000801fff78e9
> [   13.001815] virbr0: set_features() failed (-1); wanted 0x000000801fdb78c9, left 0x000000801fff78e9
> [   13.001868] virbr0: port 1(virbr0-nic) entered listening state
> [   13.001884] virbr0: port 1(virbr0-nic) entered listening state
> [   13.011555] mwifiex_pcie 0000:01:00.0 wlp1s0: set_features() failed (-1); wanted 0x0000000000006000, left 0x0000000000006800
> [   13.011619] virbr0: set_features() failed (-1); wanted 0x000000801fdb78c9, left 0x000000801fff78e9
> [   13.011671] virbr0-nic: set_features() failed (-1); wanted 0x00000080000048c1, left 0x00000080001b48c9
> [   13.011699] virbr0: set_features() failed (-1); wanted 0x000000801fdb78c9, left 0x000000801fff78e9
> [   13.011726] virbr0-nic: set_features() failed (-1); wanted 0x00000080000048c1, left 0x00000080001b48c9
> [   13.011747] virbr0: set_features() failed (-1); wanted 0x000000801fdb78c9, left 0x000000801fff78e9
> [   13.107427] virbr0: port 1(virbr0-nic) entered disabled state
> [   13.282532] Bluetooth: RFCOMM TTY layer initialized
> [   13.282938] Bluetooth: RFCOMM socket layer initialized
> [   13.284771] Bluetooth: RFCOMM ver 1.11
> [   15.569185] mwifiex_pcie 0000:01:00.0: Rx of mgmt packet failed
> [   51.727275] nf_conntrack: automatic helper assignment is deprecated and it will be removed soon. Use the iptables CT target to attach helpers instead.
> [  145.848207] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
> [  145.861772] usb 2-2: New USB device found, idVendor=1b8f, idProduct=0305
> [  145.861784] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [  145.861791] usb 2-2: Product: EXPRESS DUO
> [  145.861797] usb 2-2: Manufacturer: STT
> [  145.861802] usb 2-2: SerialNumber: 0312125800000506
> [  145.927756] usb-storage 2-2:1.0: USB Mass Storage device detected
> [  145.928129] scsi host0: usb-storage 2-2:1.0
> [  145.928874] usbcore: registered new interface driver usb-storage
> [  145.934957] usbcore: registered new interface driver uas
> [  146.930454] scsi 0:0:0:0: Direct-Access     STT      EXPRESS DUO      1.00 PQ: 0 ANSI: 5
> [  146.932927] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [  146.933068] sd 0:0:0:0: [sda] 30720000 512-byte logical blocks: (15.7 GB/14.6 GiB)
> [  146.935184] sd 0:0:0:0: [sda] Write Protect is off
> [  146.935195] sd 0:0:0:0: [sda] Mode Sense: 23 00 00 00
> [  146.935459] sd 0:0:0:0: [sda] Write cache: disabled, read cache: disabled, doesn't support DPO or FUA
> [  146.939092]  sda:
> [  146.940200] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [  147.191570] FAT-fs (sda): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
> [  175.356774] mwifiex_pcie 0000:01:00.0: Rx of mgmt packet failed


